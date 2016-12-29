/*What are the longest and shortest hotel names in the data?*/

hotelData = LOAD '/user/samples/offering.txt' USING JsonLoader
('hotel_class:double,region_id:long,url:chararray,phone:chararray,details:chararray,
address:tuple(region:chararray,street_address:chararray,postal_code:chararray,locality:chararray),
type:chararray,id:long,name:chararray');

lenHotelNm = FOREACH hotelData GENERATE name,SIZE(name) as le;

srtDec = ORDER lenHotelNm BY le desc;

srtAsc = ORDER lenHotelNm BY le asc;

longHotelNm = limit srtDec 1;

shortHotelNm = limit srtAsc 1;

store longHotelNm into '/samples/output/longHotelNm';

store shortHotelNm into '/samples/output/shortHotelNm'; 
