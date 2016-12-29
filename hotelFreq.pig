/*Store the data in hdfs and Make a frequency table of hotels by 'hotel_class'.*/

hotelData = LOAD '/user/samples/offering.txt' USING JsonLoader
('hotel_class:double,region_id:long,url:chararray,phone:chararray,details:chararray,
address:tuple(region:chararray,street_address:chararray,postal_code:chararray,locality:chararray),
type:chararray,id:long,name:chararray');

hotelClassMissing = FILTER hotelData by hotel_class is not null;

groupHotelClass = group hotelClassMissing by hotel_class;

freqHotelClass = FOREACH groupHotelClass GENERATE group, COUNT(hotelClassMissing);

store freqHotelClass into '/samples/output/hotelFreq';


	
