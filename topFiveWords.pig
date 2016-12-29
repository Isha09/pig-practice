/*Mine hotel names to see which are the top 5 most common words used in hotel names.*/

hotelData = LOAD '/user/samples/offering.txt' USING JsonLoader
('hotel_class:double,region_id:long,url:chararray,phone:chararray,details:chararray,
address:tuple(region:chararray,street_address:chararray,postal_code:chararray,locality:chararray),
type:chararray,id:long,name:chararray');

hotelNames = FOREACH hotelData GENERATE name;

splitHotelName = FOREACH hotelNames GENERATE FLATTEN(TOKENIZE(name)) as splitname;

grpdHotelName = GROUP splitHotelName BY splitname;

cntHotelNm = FOREACH grpdHotelName GENERATE group,COUNT(splitHotelName) as cnt;

srtHotelNm = ORDER cntHotelNm BY cnt DESC;

topFiveWords = LIMIT srtHotelNm 5;

store topFiveWords into '/samples/output/topFiveWordsUsed';



