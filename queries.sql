--1 How many aircrafts are there in the PLANES table?

SELECT count(tail_number) as all_aircrafts from planes;

--2 Write a query that provides a list of all planes that have a seat count of 100 or more, ordered from lowest to highest number of seats.

SELECT * from planes where seat_count >= 100 order by seat_count desc;

--3 Write a query that provides the number of flights flown by each aircraft.

SELECT tail_number, count(flight_id) as sum_flights 
from flights 
group by tail_number 
order by sum_flights desc;

--4 Write a query that provides a list of planes that flew more than 600 passengers across all flights. 
--How many planes are in that list?

SELECT f.tail_number, count(f.flight_id) as sum_flights, p.seat_count
from flights f
join planes as p
on f.tail_number = p.tail_number
group by f.tail_number
having (sum_flights * p.seat_count) >600
order by sum_flights desc;

--5 Write a query that provides the total number of flights by country.

SELECT f.tail_number, f.FLIGHT_NUMBER, f.departure_airport, 
a.COUNTRY, count(a.COUNTRY) as flights_by_country
from flights f
join airports a
on f.departure_airport = a.airport
group by a.COUNTRY
order by flights_by_country desc;

--6 Write a query that provides the total number of flights by regionality.
 
SELECT f.tail_number, f.FLIGHT_NUMBER, f.departure_airport, f.arrival_airport, sp.REGIONality, count(sp.REGIONality) as flights_by_regionality
from flights f
join city_pairs sp
on f.departure_airport = sp.departure_airport
group by sp.REGIONality
order by flights_by_regionality desc;

--7 How many CITY_PAIRS are there which depart from one of the following airports?
--KLAX, KDEN, KORD, KDET, KLGA

SELECT count(*) as sum_depart_from
from CITY_PAIRS 
where departure_airport in ('KLAX', 'KDEN', 'KORD', 'KDET', 'KLGA');

--8 How many airports are missing elevation values?

SELECT count(*) as missing_elevation_values
from airports
where elevation is Null;

--9 What flight number had the lowest passenger count (try using a subquery if you can!)?

SELECT flight_number, TAIL_NUMBER, sum(PASSENGER_COUNT)
from flights
where TAIL_NUMBER in 
(SELECT TAIL_NUMBER from Planes order by SEAT_COUNT limit 3)
group by TAIL_NUMBER
order by sum(PASSENGER_COUNT);

--10 What is the average distance flown by SKY Airline flights (nearest mile)?

SELECT AVG(DISTANCE) 
FROM flights f
join city_pairs sp
on f.DEPARTURE_AIRPORT = sp.DEPARTURE_AIRPORT AND 
f.ARRIVAL_AIRPORT = sp.ARRIVAL_AIRPORT
where TAIL_NUMBER in
(SELECT TAIL_NUMBER from planes where AIRLINE = 'SKY');








