#### Exercício 15 slide semana 8
## Utilizar o BD survey
select country,
    count(*) as respondents,
    avg(years_experience) as yrs_experience,
    avg(case when is_manager = 'Yes' then 1 else 0 end) as pct_mgrs,
    avg(case when education_level = 'Masters' then 1 else 0 end) as pct_masters
from salary_survey
group by 1 order by 2 desc;

#### Resultado da consulta

Country	    respondents	yrs_experience	pct_mgrs	pct_masters
United States	2721	230.379	        2.613	    1.731
United Kingdom	378	    10.1005	        2.487	    1.005
Canada	        135	    11.3556	        2.593	    815
Australia	    95	    9.5368	        2.526	    1.368
India	        73	    6.4795	        3.973   	3.699
Germany     	58	    10.6379     	3.276   	3.448
Netherlands	    44	    9.7955      	2.727   	1.364
Sweden	        34	    9.2941      	588     	1.176
New Zealand 	32	    10.9688     	2.813   	938
South Africa	31	    130.645	        2.581   	0
Russia	        26	    6.8846      	3.846	    6.923
Poland	        24  	7.2000	        3.333   	7.083
Ireland	        23	    11.3478	        4.348   	2.174
Denmark	        23	    11.3913	        1.304	    2.609
Romania	        22	    8.1364	        1.364   	1.364
Switzerland	    22	    11.0909	        2.727   	3.182
Italy	        21  	10.8571	        4.286   	1.905
Spain	        17	    7.4118	        4.118	    4.118
Brazil	        15	    6.9333	        2.000	    1.333
France	        15	    9.7333	        2.000   	4.667
Greece	        12	    10.5000	        6.667   	4.167
Austria	        11	    9.2000	        4.545	    1.818
Israel      	11	    9.2727	        2.727   	1.818
Belgium	        11  	9.7273      	909	        909
Czech Republic	11	    9.2727	        3.636	    5.455
Finland	        10	    138.000	        3.000   	4.000
Portugal	    9	    8.6667      	3.333	    2.222
Slovenia	    8	    9.1250      	5.000   	0
Lithuania	    8	    8.2000	        2.500	    3.750
Ukraine     	8   	7.1250      	5.000   	7.500
Hungary	        8	    8.8750	        2.500	    1.250
Bulgaria	    7	    10.2000	        4.286   	4.286
Norway	        6	    9.6667	        0       	0
Serbia and Montenegro	6	8.5000	    5.000	    3.333
Jersey	        5	    11.6000	        0       	2.000
Slovakia	    5	    7.4000      	4.000	    1.2000
Mexico	        5	    11.8000	        4.000   	4.000
Turkey	        5	    7.2000	        6.000	    2.000
Argentina	    5	    6.4000	        2.000   	0
Croatia	        5	    7.6000	        4.000   	6.000
Uganda	        4	    9.7500	        2.500	    0
Saudi Arabia	3	    8.6667	        6.667   	0
Puerto Rico 	3	    5.6667	        0       	0
United Arab Emirates	3	5.2000	    0       	0
Iceland	        2	    185.000	        0	        0
Luxembourg	    2	    135.000     	0	        5.000
Philippines	    2	    7.5000	        0	        0
Malaysia	    2	    6.5000	        5.000   	0
China	        2	    8.2000	        0	        0
Singapore	    2	    8.5000      	0	        0
Syria	        2	    2.5000	        1.2000	    0
Moldova	        2	    6.2000	        1.2000  	5.000
Malta	        1	    10.2000     	0       	0
El Salvador	    1      	1.2000	        0       	0
Colombia	    1   	8.2000	        1.2000  	1.2000
Nicaragua	    1	    7.2000	        0       	1.2000
Vietnam	        1	    5.2000	        1.2000	    0
Latvia	        1	    2.2000	        1.2000	    0
Peru	        1	    10.2000	        0	        0
Ghana	        1	    4.2000      	1.2000	    0
Kenya	        1	    5.2000	        0	        0
Jamaica	        1	    7.2000	        1.2000  	1.2000
Cayman Islands	1	    5.2000	        1.2000  	0
Guernsey	    1	    9.2000	        0	        0
Belarus	        1	    6.2000	        0	        1.2000
Macedonia	    1	    10.2000     	1.2000  	0
Estonia	        1	    180.000	        0	        0
Albania	        1	    6.2000	        0       	0
Ecuador	        1   	10.2000     	0	        0
Bolivia	        1	    160.000	        0	        0
Costa Rica	    1	    10.2000	        0	        0
Nepal	        1	    12.2000	        1.2000	    0
Indonesia	    1	    4.2000	        0	        0
Paraguay	    1	    10.2000	        1.2000  	0
Hong Kong	    1   	8.2000	        1.2000  	0
Jordan	        1	    7.2000      	0       	0
