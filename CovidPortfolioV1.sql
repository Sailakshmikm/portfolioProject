select *
from PortfolioProject ..CovidDeaths
order by 3,4


select *
from PortfolioProject..CovidVaccinations
order by 3,4

--- select the data that we are going to be using 

select location,date, total_cases, new_cases, total_deaths,population
from PortfolioProject ..CovidDeaths
order by 1,2

--looking at total cases vs total deaths

select location,date, total_cases, total_deaths,(total_deaths/total_cases)*100 as DeathsPercentage
from PortfolioProject ..CovidDeaths
where location like '%India%'
order by 1,2

--looking at total cases Vz population
--show total percerntage of population got covid

 select location, date, population, total_cases,(total_cases/population)*100 as covid_infectionrate
from PortfolioProject ..CovidDeaths
where location like '%India%'
order by 1,2

--- looking at the countries where higest infection rate compare to population 
 select location, population, max(total_cases),max(total_cases/population)*100 as covid_infectionrate
from PortfolioProject ..CovidDeaths
where continent is not null
group by location,population
--where location like '%India%'
order by covid_infectionrate desc

--countries with higest death rate per population 

 select location, population, max(cast(total_deaths as int)) as maxcovidedeath, max(total_deaths/population)*100 as maxcovid_deathrate
from PortfolioProject ..CovidDeaths
where continent is not null
group by location,population
--where location like '%India%'
order by maxcovid_deathrate desc


--countries with higest death rate per population 

 select location,  max(cast(total_deaths as int)) as total_deathcount 
from PortfolioProject ..CovidDeaths
where continent is not null
group by location
--where location like '%India%'
order by total_deathcount desc

--break things down by continent 

select location,  max(cast(total_deaths as int)) as total_deathcount 
from PortfolioProject ..CovidDeaths
where continent is null
group by location
--where location like '%India%'
order by total_deathcount desc

--showing continents with higest death count 

select location,  max(cast(total_deaths as int)) as total_deathcount 
from PortfolioProject ..CovidDeaths
where continent is null
group by location
--where location like '%India%'
order by total_deathcount desc

--Global numbers 

select continent, date,total_cases, total_deaths,(total_deaths/total_cases)*100 as death_percentage 
from PortfolioProject ..CovidDeaths
where continent is not null
--group by continent 
order by 1,2

select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int))as total_deaths, 
SUM(cast(new_deaths as int))/SUM(new_cases)*100 as death_percentage
from PortfolioProject ..CovidDeaths
where continent is not null
--group by date
--where location like '%India%'
order by 1,2

--joining both the table

select * 
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
on dea.location = vac.location
   and dea.date = vac.date

-- loking at total poulation Vs total vaccinations 

select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations 
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
on dea.location = vac.location
   and dea.date = vac.date
   where dea.continent is not NULL
   order by 2,3


 -- checking the increments in vaccination and aded up on your next day count 


 select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
 SUM(cast(vac.new_vaccinations as int)) over (partition by dea.location order by dea.location, dea.date ) as increment 
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
on dea.location = vac.location
   and dea.date = vac.date
   where dea.continent is not NULL
   order by 2,3






