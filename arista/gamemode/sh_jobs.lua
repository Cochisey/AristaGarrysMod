AddCSLuaFile()

--[[
Example of how to do a job:

TEAM_POLICEOFFICER = arista.team.add("Police Officer", {
	color = Color(100, 155, 255, 255), -- Color of job in scoreboard and chat.
	males = "models/player/riot.mdl", -- Male models, can be a string, table or nil. If nil uses citizen models.
	female = nil, -- Female models, can be a string, table or nil. If male is nil uses citizen models, if male exists then uses male models.
	description = "Maintains the city and arrests criminals.", -- Description of job shown in menu + access.
	salary = 250, -- Money per 'payday'.
	limit = 15, -- The limit of players that can be this job.
	access = nil, -- Any special gamemode access levels they get, listed below.
	blacklist = nil,
	group = { -- The jobs group data.
		gang = GANG_POLICE, -- The gang they belong to.
		access = "", -- Special group access.
		level = 2, -- Group access level, 1 is group base, 2 is things like cops, 3 things like police commander.
		group = GROUP_OFFICIALS, -- Group they belong to, similar to gang but more general.
	},
	cantuse = { -- Categories they are banned from using, eg, cops cant use explosives and illegal stuff.
		CATEGORY_ILLEGAL_GOODS,
		CATEGORY_ILLEGAL_WEAPONS,
		CATEGORY_EXPLOSIVES,
	},
	canmake = nil, -- Specific categories they CAN produce from the store.
	guns = {"cider_baton"}, -- Any weapons they spawn with.
	ammo = { -- Any ammo they spawn with.
		pistol = 60,
	},
	timelimit = nil, -- How long you can be this job at once.
	waiting = nil, -- How long it takes to rejoin this job.
})
]]

--[[
Access flags:
b = boss - can demote members of the same level. Restricted to a gang if used on a gang member
d = demote members of lower level. Restricted to a gang if used on a gang member
g = can give/take ents to/from gang
D = underlings can vote to depose
M = All group-to-group transitions must go through this.

Old format:
(name,color,males,females,group,description,salary,limit,access,blacklist,canmake,cantuse,time,guns,ammo)
]]

-- This has to be here due to the load-order.
-- Anything in this will be given to groups with default store access.
arista.config.defaults.jobCategories = {CATEGORY_VEHICLES, CATEGORY_MISC, CATEGORY_CONTRABAND}

if (GM or GAMEMODE):GetPlugin("officals") then
GROUP_OFFICIALS	= arista.team.addGroup("Officials", "Join the force for 'Public Good', maintaining law and order.", "P")

GANG_OFFICIALS	= arista.team.addGang(GROUP_OFFICIALS, "The Officials", "models/player/breen.mdl", "Enough red tape to drown a continent.")
GANG_POLICE			= arista.team.addGang(GROUP_OFFICIALS, "The Police", "models/player/riot.mdl", "Less talk, more action!")

TEAM_MAYOR = arista.team.add("City Mayor", {
	color = Color(0, 0, 255, 255),
	males = "models/player/breen.mdl",
	females = "models/player/mossman.mdl",

	description = "Runs the city and keeps it in shape.",

	mayor = true,

	salary = 500,
	limit = 1,

	access = "bdgeD",

	group = {
		gang = GANG_OFFICIALS,
		access = "D",
		level = 3,
		group = GROUP_OFFICIALS,
	},
	cantuse = {CATEGORY_ILLEGAL_GOODS, CATEGORY_ILLEGAL_WEAPONS, CATEGORY_EXPLOSIVES},
})

TEAM_VICEMAYOR = arista.team.add("Vice-Mayor", {
	color = Color(0, 0, 255, 255),
	males = "models/player/breen.mdl",
	females = "models/player/mossman.mdl",

	description = "Runs the city and keeps it in shape.",

	vicemayor = true,

	salary = 500,
	limit = 1,

	access = "dgeD",

	group = {
		gang = GANG_OFFICIALS,
		access = "D",
		level = 2,
		group = GROUP_OFFICIALS,
	},
	cantuse = {CATEGORY_ILLEGAL_GOODS, CATEGORY_ILLEGAL_WEAPONS, CATEGORY_EXPLOSIVES},
})

TEAM_POLICECOMMANDER = arista.team.add("Police Chief", {
	color = Color(100, 155, 255, 255),
	males = "models/player/urban.mdl",
	description = "Maintains the city and arrests criminals while having supervision over their police officers. Also reports to the City Mayor & Vice Mayor",

	commander = true,

	salary = 350,
	limit = 1,

	access = "",

	guns = {"arista_baton"},
	ammo = {
		pistol = 60,
	},

	group = {
		gang = GANG_POLICE,
		access = "D",
		level = 2,
		group = GROUP_OFFICIALS,
	},
	cantuse = {CATEGORY_ILLEGAL_GOODS, CATEGORY_ILLEGAL_WEAPONS, CATEGORY_EXPLOSIVES},
})

TEAM_POLICEOFFICER = arista.team.add("Police Officer", {
	color = Color(100, 155, 255, 255),
    females = "models/player/kerry/thalia_sheriff_02.mdl",
	males = "models/player/riot.mdl",
	description = "Controls the police and criminal justice.",

	officer = true,

	salary = 250,
	limit = 15,

	access = "deD",

	guns = {"arista_baton"},
	ammo = {
		pistol = 60,
	},

	group = {
		gang = GANG_POLICE,
		access = "",
		level = 1,--2, -- not base group, but we dont have other jobs so for now
		group = GROUP_OFFICIALS,
	},
	cantuse = {CATEGORY_ILLEGAL_GOODS, CATEGORY_ILLEGAL_WEAPONS, CATEGORY_EXPLOSIVES},
})

TEAM_SECRETARY = arista.team.add("City Mayor's Personal Secretary", {
	color = Color(50, 200, 200, 255),
	males = {
		"models/player/Hostage/Hostage_01.mdl",
		"models/player/Hostage/Hostage_04.mdl"
	},
	description = "Maintains public relations and does misc jobs.",

	salary = 350,
	limit = 4,

	access = "",

	group = {
		gang = GANG_OFFICIALS,
		access = "",
		level = 1,
		group = GROUP_OFFICIALS,
	},
	cantuse = {CATEGORY_ILLEGAL_GOODS, CATEGORY_ILLEGAL_WEAPONS, CATEGORY_EXPLOSIVES},
})

TEAM_FIREFIGHTER = arista.team.add("FireFighter", {
	color = Color(25, 150, 150, 255),
	males = "models/player/portal/Male_06_fireman.mdl",
	description = "A worker at the fire department, trained to tackle fires.",

	salary = 200,
	limit = 3,

	access = "",
	fire = true,

	guns = {"arista_extinguisher"},

	group = {
		gang = GANG_OFFICIALS,
		access = "",
		level = 1,
		group = GROUP_OFFICIALS,
	},
	cantuse = {CATEGORY_ILLEGAL_GOODS, CATEGORY_ILLEGAL_WEAPONS, CATEGORY_EXPLOSIVES},
})
end


GROUP_CIVILIANS	= arista.team.addGroup("Civilians", "Join the ordinary and (generally) law-abiding civilians.")
GANG_CIVILIANS	= arista.team.addGang(GROUP_CIVILIANS, "The Civilians", "models/player/Group01/male_07.mdl", "Keep me out of this!")

TEAM_CITIZEN = arista.team.add("Citizen", {
	color = Color(25, 150, 25, 255),
	description = "A regular Citizen living in the city.",

	salary = 200,

	access = "",

	group = {
		gang = GANG_CIVILIANS,
		access = "M",
		level = 1,
		group = GROUP_CIVILIANS,
	},
	cantuse = {CATEGORY_ILLEGAL_WEAPONS, CATEGORY_EXPLOSIVES, CATEGORY_POLICE_WEAPONS},
})

TEAM_GUNDEAL = arista.team.add("Gun Dealer", {
	color = Color(170, 150, 25, 255),
	males = "models/player/leet.mdl",
    females = "models/player/alyx.mdl",
	description = "The owner of a gun store.",

	salary = 220,
    limit = 2,

	access = "",

	group = {
		gang = GANG_CIVILIANS,
		access = "",
		level = 1,
		group = GROUP_CIVILIANS,
	},
	canmake = {CATEGORY_VEHICLES, CATEGORY_CONTRABAND, CATEGORY_POLICE_WEAPONS, CATEGORY_WEAPONS, CATEGORY_AMMO}, -- I might change cop weapons here
	cantuse = {CATEGORY_ILLEGAL_GOODS, CATEGORY_EXPLOSIVES},
})

if (GM or GAMEMODE):GetPlugin("hungermod") then
TEAM_CHEF = arista.team.add("Chef", {
	color = Color(255, 125, 200, 255),
	description = "Sells food to the city's inhabitants.",
	salary = 220,
	limit = 3,
    females = "models/fearless/chef2.mdl",
    males = "models/fearless/chef1.mdl",

	access = "",

	group = {
		gang = GANG_CIVILIANS,
		access = "",
		level = 1,
		group = GROUP_CIVILIANS,
	},
	canmake = {CATEGORY_VEHICLES, CATEGORY_CONTRABAND, CATEGORY_FOOD, CATEGORY_ALCOHOL, CATEGORY_DRINKS},
	cantuse = {CATEGORY_ILLEGAL_GOODS, CATEGORY_ILLEGAL_WEAPONS, CATEGORY_EXPLOSIVES, CATEGORY_POLICE_WEAPONS},
})
end

TEAM_DOCTOR = arista.team.add("Doctor", {
	color = Color(125, 225, 150, 255),
	description = "Deals medical supplies to the city's inhabitants.",

	males = "models/player/Group02/male_08.mdl",
	females = "models/player/Group03m/Female_02.mdl",

	salary = 250,
	limit = 2,

	access = "h",

	group = {
		gang = GANG_CIVILIANS,
		access = "",
		level = 1,
		group = GROUP_CIVILIANS,
	},
	canmake = {CATEGORY_VEHICLES, CATEGORY_CONTRABAND, CATEGORY_DRUGS},
	cantuse = {CATEGORY_ILLEGAL_GOODS, CATEGORY_ILLEGAL_WEAPONS, CATEGORY_EXPLOSIVES, CATEGORY_POLICE_WEAPONS},
})

TEAM_MECHANIC = arista.team.add("Mechanic", {
	color = Color(175, 175, 175, 255),
	males = "models/mechanic/mechanic_m_01.mdl",
	description = "Repairs damaged vehicles.",

	salary = 150,
	limit = 2,

	access = "",

	guns = {"arista_repair"},

	group = {
		gang = GANG_CIVILIANS,
		access = "",
		level = 1,
		group = GROUP_CIVILIANS,
	},
	canmake = {CATEGORY_VEHICLES, CATEGORY_CONTRABAND},
	cantuse = {CATEGORY_ILLEGAL_GOODS, CATEGORY_ILLEGAL_WEAPONS, CATEGORY_EXPLOSIVES, CATEGORY_POLICE_WEAPONS},
})

GROUP_UNDERGROUND	= arista.team.addGroup("The Underground", "Join the underground for more fun, but harsher treatment if caught.")
GANG_UNDERGROUND	= arista.team.addGang(GROUP_UNDERGROUND, "The Underground", "models/player/Group03/male_07.mdl", "'Fuck the police!'")
GANG_MAFIA = arista.team.addGang(GROUP_UNDERGROUND, "The Mafia", "models/player/Group03/male_07.mdl", "'Wherever there's opportunity, the mafia will be there.'")

TEAM_BLACKMARKETDEALER = arista.team.add("Blackmarket Dealer", {
	color = Color(125, 125, 125, 255),
	description = "Supplys people with goods not found in the public market.",

	salary = 100,
	limit = 2,

	access = "",

	group = {
		gang = GANG_UNDERGROUND,
		access = "",
		level = 1,
		group = GROUP_UNDERGROUND,
	},
	canmake = {CATEGORY_VEHICLES, CATEGORY_EXPLOSIVES, CATEGORY_CONTRABAND, CATEGORY_POLICE_WEAPONS, CATEGORY_ILLEGAL_GOODS, CATEGORY_ILLEGAL_WEAPONS, CATEGORY_AMMO},
})

TEAM_CHAV = arista.team.add("Anarchist", {
	color = Color(135, 125, 125, 255),
	description = "The scum of society, roaming around commiting petty crimes and being a general nuisance.",

	salary = 100,
	limit = 4,

	access = "",

	group = {
		gang = GANG_UNDERGROUND,
		access = "",
		level = 1,
		group = GROUP_UNDERGROUND,
	},
})

--[[
TEAM_GANGSTER = arista.team.add("Gangster", {
	color = Color(125, 125, 135, 255),
	description = "Members of a large time organised crime mob.",

	salary = 120,
	limit = 6,

	access = "",

	group = {
		gang = GANG_UNDERGROUND,
		access = "",
		level = 1,
		group = GROUP_UNDERGROUND,
	},
})]]

TEAM_MAFIABOSS = arista.team.add("The Godfather", {
	color = Color(112, 0, 0, 255),
	description = "Leader of a large time organised crime mob.",

	salary = 175,
	limit = 1,

	access = "dgeD",

	group = {
		gang = GANG_MAFIA,
		access = "D",
		level = 2,
		group = GROUP_UNDERGROUND,
	},
})

TEAM_MAFIA = arista.team.add("Mafia Goon", {
	color = Color(102, 0, 0, 255),
	description = "Member of a large time organised crime mob.",

	salary = 125,
	limit = 4,

	access = "",

	group = {
		gang = GANG_MAFIA,
		access = "",
		level = 1,
		group = GROUP_UNDERGROUND,
	},
})


-- Default job.
TEAM_DEFAULT = TEAM_CITIZEN
