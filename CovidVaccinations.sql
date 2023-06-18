SELECT *
FROM mysqlprojects.covidvaccinations
order by 3,4;
-- Joining Both tables to the location and date
Select * 
From mysqlprojects.coviddeaths dea
Join mysqlprojects.covidvaccinations vac
On dea.location = vac.location
and dea.date = vac.date
-- look for population vs vaccinations
Select dea.location, dea.date, dea.population, vac.new_vaccinations 
From mysqlprojects.coviddeaths dea
Join mysqlprojects.covidvaccinations vac
On dea.location = vac.location
order by 2, 3
-- sum of the vaccinations from the data
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(Cast(vac.new_vaccinations as int)) as sum_vaccinations
From mysqlprojects.coviddeaths dea
Join mysqlprojects.covidvaccinations vac
On dea.location = vac.location
 and dea.date - vac.date
 where dea.continent is not null
-- percent of population that is vaccinated
Select dea.continent, dea.location, dea.date, dea.population, (CAST(vac.total_vaccinations as int)/ dea.population)
From mysqlprojects.coviddeaths dea
Join mysqlprojects.covidvaccinations vac
On dea.location = vac.location
 and dea.date = vac.date
 -- Use CTE
 With PopvsVac (Continent, Location, population, new_vaccinations, RollingPeopleVaccinated)
 as 
 (
 Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
 , SUM(Convert(int, vac.new_vaccinations)) OVER(Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
 From mysqlprojects.coviddeaths dea
 Join mysqlprojects.covidvaccinations vac
  on dea.location = vac.location
  and dea.date = vac.date
  where dea.continent is not null
 )
 Select *, (RollingPeopleVaccinated/ Population)*100
 From PopvsVac