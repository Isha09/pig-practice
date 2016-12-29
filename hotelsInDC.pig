/*Number of Hotels in DC*/

hotelData = LOAD '/user/samples/offering.txt' USING JsonLoader
('hotel_class:double,region_id:long,url:chararray,phone:chararray,details:chararray,
address:tuple(region:chararray,street_address:chararray,postal_code:chararray,locality:chararray),
type:chararray,id:long,name:chararray');

hotelDC = FILTER hotelData by address.region == 'DC';

groupHotelDC = GROUP hotelDC ALL;

totHotelDC = FOREACH groupHotelDC GENERATE COUNT(hotelDC) as totalHotelsInDC;

store totHotelDC into '/samples/output/hotelInDC';
