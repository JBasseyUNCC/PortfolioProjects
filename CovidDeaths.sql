
select *
from mysqlprojects.coviddeaths
 
 -- Looking at total cases vs total deaths 

 select location, date, total_cases, total_deaths, (total_deaths/ total_cases)*100 as DeathPercentage
 from mysqlprojects.coviddeaths
order by 1, 2

-- look at the highest death percentages -- 
select location, date, total_cases, total_deaths, (total_deaths/ total_cases)*100 as DeathPercentage
 from mysqlprojects.coviddeaths
order by DeathPercentage desc

-- looking at total cases vs population 
-- shows the percentage of population that caught covid
select location, total_cases, population, (total_cases/ population)*100 as InfectionPercentage
 from mysqlprojects.coviddeaths
order by InfectionPercentage desc
