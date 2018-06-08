/**
* @author Kaptio Ehf.
* @description Controller for prototype version of Package Search
*/

public class TripAvailabilitySearchController {

	//--------------------------------------------------------------
	// MOCK DATA GENERATOR
	//--------------------------------------------------------------

	private void generateMockData(){

		/*
			Mock data generator creates a package object with a list of departures. The JSON structure is:
			[{
				"name" : "package name",
				"lengthDays" : 11,
				"tripTypes" : ["Land", "Active"],
				"interestTypes" : ["Photography", "People & Culture"],
				"regions" : ["Europe", "Africa"],
				"departures" : [
					{
						"departureDate" : 2018-05-05,
						"arrivalDate" : 2018-05-12,
						"month" : "05 April",
						"year" : "2018",
						"departureName" : "Apr 5-12, 2018",
						"perPersonDouble" : 12000,
						"perPersonSingle" : 14500,
					}, {
						"departureDate" : 2018-05-25,
						"arrivalDate" : 2018-06-9,
						"month" : "05 April",
						"year" : "2018",
						"departureName" : "Apr 25-Jun 12, 2018",
						"perPersonDouble" : 12000,
						"perPersonSingle" : 14500,
					}
				]
			}]
		*/

		this.mockData = new List<Pkg>{
			// RAGNAR TODO : ADD MORE MOCK DATA

			// Southern Spain and Morocco
			new Pkg('0', 'Southern Spain and Morocco', // package name
					14, // package length
					new String[]{'Land'}, // tripType
					new String[]{'People and Culture'}, // interest
					new String[]{'Europe', 'Africa'},
					new String[]{ '2019-03-17', '2019-04-7', '2019-09-22', '2019-10-20'}, //dates
					9695, // perPersonDouble
					11680, // perPersonSingle
					new Integer[]{ 6, 8, 10, 12 } // Availability
			),

			// Some other package
			new Pkg('1', 'Kenya: Up Close with Elephants, Rhinos and Big Cats', // package name
					10, // package length
					new String[]{'Land'}, // tripType
					new String[]{'Nature & Wildlife'}, // interest
					new String[]{'Africa'},
					new String[]{ '2019-03-17', '2019-04-7', '2019-09-22', '2019-10-20'}, //dates
					9695, // perPersonDouble
					11680, // perPersonSingle
					new Integer[]{ 5, 7, 9, 11 } // Availability
			),

			// Alaska Sea Kayaking Adventure
			new Pkg('1', 'Alaska Sea Kayaking Adventure', // package name
					9, // package length
					new String[]{'Active'}, // tripType
					new String[]{'Nature & Wildlife', 'Rafting'}, // interest
					new String[]{'North America'},
					new String[]{ '2018-06-30', '2018-07-16', '2018-08-3', '2018-08-5'}, //dates
					9695, // perPersonDouble
					11680, // perPersonSingle
					new Integer[]{ 5, 7, 9, 11 } // Availability
			),

				// Alaska Sea Kayaking Adventure
			new Pkg('1', 'Borneo Wildlife Adventure', // package name
					9, // package length
					new String[]{'Active'}, // tripType
					new String[]{'Nature & Wildlife', 'Rafting'}, // interest
					new String[]{'Asia'},
					new String[]{ '2018-06-20', '2018-07-25', '2018-08-15', '2018-08-20'}, //dates
					9695, // perPersonDouble
					11680, // perPersonSingle
					new Integer[]{ 5, 7, 9, 11 } // Availability
			),
			
			// Alaska Sea Kayaking Adventure
			new Pkg('1', 'Ireland Family Expedition', // package name
					9, // package length
					new String[]{'Family'}, // tripType
					new String[]{'Nature & Wildlife', 'History & Archaeology', 'People & Culture'}, // interest
					new String[]{'Europe'},
					new String[]{ '2019-06-30', '2019-07-16', '2019-08-3', '2019-08-5'}, //dates
					12450, // perPersonDouble
					15900, // perPersonSingle
					new Integer[]{ 5, 7, 9, 11 } // Availability
			),

			// Alaska Sea Kayaking Adventure
			new Pkg('1', 'Alaska: Denali to Kenai Fjords Family Expedition', // package name
					9, // package length
					new String[]{'Active'}, // tripType
					new String[]{'Nature & Wildlife', 'Rafting'}, // interest
					new String[]{'North America'},
					new String[]{ '2018-07-30', '2018-08-16', '2018-09-3', '2018-09-5'}, //dates
					15402, // perPersonDouble
					17050, // perPersonSingle
					new Integer[]{ 5, 7, 9, 11 } // Availability
			)

		};

		this.mockDataJSON = JSON.serialize(this.mockData);
	}

	public TripAvailabilitySearchController(){
		generateMockData();
		buildDynamicFilters();
	}

	//--------------------------------------------------------------
	// Filters
	//--------------------------------------------------------------
	private Filters filters { get; private set; }
	public String filtersJSON { get; private set; }

	public class Filters {
		public List<String> byPackage { get; private set; }
		public List<String> byTripType { get; private set; }
		public List<String> byInterest { get; private set; }
		public List<String> byRegion { get; private set; }
		public List<String> byDepartureYear { get; private set; }
		public List<String> byDepartureMonth { get; private set; }
	}

	public void buildDynamicFilters(){
		Set<String> byPackageSet = new Set<String>();
		Set<String> byTripTypeSet = new Set<String>();
		Set<String> byInterestSet = new Set<String>();
		Set<String> byRegionSet = new Set<String>();
		Set<String> byDepartureYearSet = new Set<String>();
		Set<String> byDepartureMonthSet = new Set<String>();

		for(Pkg pkg : mockData){
				byPackageSet.add(pkg.name);
				byTripTypeSet.addAll(pkg.tripTypes);
				byInterestSet.addAll(pkg.interestTypes);
				byRegionSet.addAll(pkg.regions);
			for(Departure departure : pkg.departures){
				byDepartureYearSet.add(departure.year);
				byDepartureMonthSet.add(departure.month);
			}
		}

		this.filters = new Filters();

		this.filters.byPackage = new List<String>(byPackageSet);
		this.filters.byPackage.sort();
		this.filters.byPackage.add(0, 'Any');

		this.filters.byTripType = new List<String>(byTripTypeSet);
		this.filters.byTripType.sort();
		this.filters.byTripType.add(0, 'Any');

		this.filters.byInterest = new List<String>(byInterestSet);
		this.filters.byInterest.sort();
		this.filters.byInterest.add(0, 'Any');

		this.filters.byRegion = new List<String>(byRegionSet);
		this.filters.byRegion.sort();
		this.filters.byRegion.add(0, 'Any');

		this.filters.byDepartureYear = new List<String>(byDepartureYearSet);
		this.filters.byDepartureYear.sort();
		this.filters.byDepartureYear.add(0, 'Any');

		this.filters.byDepartureMonth = new List<String>(byDepartureMonthSet);
		this.filters.byDepartureMonth.sort();
		this.filters.byDepartureMonth.add(0, 'Any');

		this.filtersJSON = JSON.serialize(this.filters);
	}
		//--------------------------------------------------------------
		// Mock Data
		//--------------------------------------------------------------

	private List<Pkg> mockData { get; private set; }
	public String mockDataJSON { get; private set; }

	public class Pkg { // pgk = package. package class name is reserved by Salesforce
		public String id {get; private set; }
		public String name { get; private set; }
		public Integer lengthDays { get; private set; }
		public List<String> tripTypes { get; private set; }
		public List<String> interestTypes { get; private set; }
		public List<String> regions { get; private set; }
		public List<Departure> departures { get; private set; }

		public Pkg(
			String id,
			String name,
			Integer lengthDays,
			String[] tripTypes,
			String[] interestTypes,
			String[] regions,
			String[] departureDates,
			Decimal perPersonDouble,
			Decimal perPersonSingle,
			Integer[] availabilities
		){
			this.id = id;
			this.name = name + ' (' +String.valueOf(lengthDays) + ' days)';
			this.lengthDays = lengthDays;
			this.tripTypes = tripTypes;
			this.interestTypes = interestTypes;
			this.regions = regions;
			this.departures = new List<Departure>();
			for(Integer i=0; i<departureDates.size(); i++) {
				String departureDate = departureDates[i];
				Integer availability = availabilities[i];
				Date castedDate = Date.valueOf(departureDate);
				departures.add( new Departure(castedDate, lengthDays, perPersonDouble, perPersonSingle, availability) );
			}
		}
	}

	public class Departure {
		public Date departureDate { get; private set; }
		public Date arrivalDate { get; private set; }
		public String month { get; private set; }
		public String year { get; private set; }
		public String departureName { get; private set; }
		public Decimal perPersonDouble { get; private set; }
		public Decimal perPersonSingle { get; private set; }
		public Integer availability { get; private set; }

		public Departure(
			Date departureDate,
			Integer lengthDays,
			Decimal perPersonDouble,
			Decimal perPersonSingle,
			Integer availability
		){

			this.departureDate = departureDate;
			this.arrivalDate = departureDate+lengthDays;

			String monthString = String.valueOf(departureDate.month());
			if(monthString.length() == 1){
				monthString = '0'+monthString;
			}
			Datetime departureDateTime = Datetime.newInstance(departureDate.year(), departureDate.month(),departureDate.day());
			Datetime arrivalDateTime = Datetime.newInstance(arrivalDate.year(), arrivalDate.month(),arrivalDate.day());
			this.month = monthString + ' ' + departureDateTime.format('MMM');
			this.year = String.valueOf(departureDate.year());
			this.perPersonDouble = perPersonDouble;
			this.perPersonSingle = perPersonSingle;
			this.availability = availability;
		}
	}
}