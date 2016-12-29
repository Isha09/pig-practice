/*Hotels without hotel_class information.*/

hotelData = LOAD '/user/samples/offering.txt' USING JsonLoader
('hotel_class:double,region_id:long,url:chararray,phone:chararray,details:chararray,
address:tuple(region:chararray,street_address:chararray,postal_code:chararray,locality:chararray),
type:chararray,id:long,name:chararray');

hotelClassMissing = FILTER hotelData by hotel_class is null;

store hotelClassMissing into '/samples/output/hotelClassMissing';
