source(output(
		country as string,
		indicator as string,
		date as string,
		year_week as string,
		value as integer,
		source as string,
		url as string
	),
	allowSchemaDrift: true,
	validateSchema: false,
	ignoreNoFilesFound: false) ~> HospitalAdmissions
source(output(
		country as string,
		country_code_2_digit as string,
		country_code_3_digit as string,
		continent as string,
		population as string
	),
	allowSchemaDrift: true,
	validateSchema: false,
	ignoreNoFilesFound: false) ~> CountrySource
source(output(
		date_key as string,
		date as string,
		year as string,
		month as string,
		day as string,
		day_name as string,
		day_of_year as string,
		week_of_month as string,
		week_of_year as string,
		month_name as string,
		year_month as string,
		year_week as string
	),
	allowSchemaDrift: true,
	validateSchema: false,
	ignoreNoFilesFound: false) ~> DimDateSource
HospitalAdmissions select(mapColumn(
		country,
		indicator,
		reported_date = date,
		reported_year_week = year_week,
		value,
		source
	),
	skipDuplicateMapInputs: true,
	skipDuplicateMapOutputs: true) ~> SelectRequiredColumn
SelectRequiredColumn, CountrySource lookup(SelectRequiredColumn@country == CountrySource@country,
	multiple: false,
	pickup: 'any',
	broadcast: 'auto')~> CountrySourceLookup
CountrySourceLookup select(mapColumn(
		country = SelectRequiredColumn@country,
		indicator,
		reported_date,
		reported_year_week,
		value,
		source,
		country = CountrySource@country,
		country_code_2_digit,
		country_code_3_digit,
		population
	),
	skipDuplicateMapInputs: true,
	skipDuplicateMapOutputs: true) ~> SelectRequiredColumnsfromLookup
SelectRequiredColumnsfromLookup split(indicator=='Weekly new hospital admissions per 100k'||indicator=='Weekly new ICU admissions per 100k',
	disjoint: false) ~> SplitDailyandWeekly@(Weekly, Daily)
DimDateSource derive(edcd_year_Week = year+'-W'+lpad(week_of_year,2,'0')) ~> DerivedEdcdYearWeek
DerivedEdcdYearWeek aggregate(groupBy(edcd_year_Week),
	week_start_date = min(date),
		week_end_date = max(date)) ~> AggDimDate
SplitDailyandWeekly@Weekly, AggDimDate join(reported_year_week == edcd_year_Week,
	joinType:'inner',
	matchType:'exact',
	ignoreSpaces: false,
	broadcast: 'auto')~> JoinwithDate
JoinwithDate pivot(groupBy(country,
		country_code_2_digit,
		country_code_3_digit,
		population,
		reported_year_week,
		source,
		week_start_date,
		week_end_date),
	pivotBy(indicator, ['Weekly new hospital admissions per 100k', 'Weekly new ICU admissions per 100k']),
	Count = sum(value),
	columnNaming: '$V_$N',
	lateral: true) ~> PivotWeekly
SplitDailyandWeekly@Daily pivot(groupBy(country,
		country_code_2_digit,
		country_code_3_digit,
		population,
		reported_date,
		source),
	pivotBy(indicator, ['Daily hospital occupancy', 'Daily ICU occupancy']),
	Count = sum(value),
	columnNaming: '$V_$N',
	lateral: true) ~> PivotDaily
PivotWeekly sort(desc(reported_year_week, true),
	asc(country, true)) ~> SortWeekly
PivotDaily sort(desc(reported_date, true),
	asc(country, true)) ~> SortDaily
SortWeekly select(mapColumn(
		country,
		country_code_2_digit,
		country_code_3_digit,
		population,
		reported_year_week,
		source,
		reported_week_start_date = week_start_date,
		reported_week_end_date = week_end_date,
		new_hospital_occupancy_count = {Weekly new hospital admissions per 100k_Count},
		new_icu_occupancy_count = {Weekly new ICU admissions per 100k_Count}
	),
	skipDuplicateMapInputs: true,
	skipDuplicateMapOutputs: true) ~> SelectWeekly
SortDaily select(mapColumn(
		country,
		country_code_2_digit,
		country_code_3_digit,
		population,
		reported_date,
		source,
		new_hospital_occupancy_count = {Daily hospital occupancy_Count},
		new_icu_occupancy_count = {Daily ICU occupancy_Count}
	),
	skipDuplicateMapInputs: true,
	skipDuplicateMapOutputs: true) ~> SelectDaily
SelectWeekly sink(allowSchemaDrift: true,
	validateSchema: false,
	umask: 0022,
	preCommands: [],
	postCommands: [],
	skipDuplicateMapInputs: true,
	skipDuplicateMapOutputs: true) ~> WeeklySink
SelectDaily sink(allowSchemaDrift: true,
	validateSchema: false,
	umask: 0022,
	preCommands: [],
	postCommands: [],
	skipDuplicateMapInputs: true,
	skipDuplicateMapOutputs: true) ~> DailySink