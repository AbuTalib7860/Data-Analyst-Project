create database PortfolioProject;
use PortfolioProject;

select * from PortfolioProject.coviddeaths order by 3,4;
select * from PortfolioProject.covidvaccinations order by 3,4;

-- Select data that we use 
select location,last_updated_date,total_cases,new_cases,total_deaths,population
from PortfolioProject.coviddeaths order by 1,2;

-- look at total cases vs deaths
select location,last_updated_date,total_cases,total_deaths,(total_deaths/total_cases)*100 as deathPercentage
from PortfolioProject.coviddeaths where location like '%united%' order by 1,2;

-- look at total cases vs population
select location,last_updated_date,population,total_cases,(total_cases/population)*100 as popuPercentage
from PortfolioProject.coviddeaths order by 1,2;

-- look at countries with highest infection rate vs population
select location,population,max(total_cases) as infectionCount,max((total_cases/population))*100 as HighInfecPercentage
from PortfolioProject.coviddeaths group by location,population order by HighInfecPercentage desc;

-- look at countries with highest death rate vs population
select location,max(total_deaths) as totDeathCount
from PortfolioProject.coviddeaths group by location order by totDeathCount desc;


-- look at continent with highest death rate vs population
-- look at continent with highest death count per population
select continent,max(total_deaths) as totDeathCount
from PortfolioProject.coviddeaths 
group by continent order by totDeathCount desc;

-- Global Numbers 
select sum(new_cases) as totcases, sum(new_deaths) as totdeath,sum(new_deaths)/ sum(new_cases) *100 as deathPercent
-- total_deaths,(total_deaths/total_cases)*100 as deathPercentage
from PortfolioProject.coviddeaths
--  where location like '%united%'
-- where continent is not null
--  group by last_updated_date 
 order by 1,2;
 
 -- looking at total population vs vaccinations
 select dea.continent,dea.location,dea.last_updated_date,dea.population,vac.new_vaccinations ,
 sum(vac.new_vaccinations) over (partition by dea.location order by dea.location,dea.last_updated_date) as rollvac
 from portfolioproject.coviddeaths dea join portfolioproject.covidvaccinations vac
 on dea.location=vac.location
 and dea.last_updated_date=vac.last_updated_date order by 2,3;
 
 