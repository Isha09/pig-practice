/*Are there any repeated hotel records in the data?*/

hotelData = LOAD '/user/samples/offering.txt' USING JsonLoader
('hotel_class:double,region_id:long,url:chararray,phone:chararray,details:chararray,
address:tuple(region:chararray,street_address:chararray,postal_code:chararray,locality:chararray),
type:chararray,id:long,name:chararray');

dupRec = group hotelData by (hotel_class,region_id,url,phone,details,address.region,address.street_address,address.postal_code,address.locality,type,id,name);

countDupRec = FOREACH dupRec GENERATE group, COUNT(hotelData) as cnt;

dupHotelRecords = FILTER countDupRec by cnt>1;

store dupHotelRecords into '/samples/output/dupHotelRecords';

