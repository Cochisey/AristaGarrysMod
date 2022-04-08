arista.config.storage_type = "pdata"

arista.config.sql = {}

-- SQL Table or pdata string, depending on what you use.
arista.config.sql.database = "dkb_arista_dev"
arista.config.sql.table = "arista_data"
arista.config.sql.host = "51.254.45.175"
arista.config.sql.port = 3306
arista.config.sql.user = "db32546"
arista.config.sql.pass = "203TxIG5ph"

-- Stuff that's saved in the database, do not add any extra members unless you have also added them to your SQL!
arista.config.database = {
	-- The money that each player starts with.
	money = 1000,
	-- The clan that each player belongs to by default.
	clan = "",
	-- The default inventory size.
	inventorySize = 40,
	-- The detailed information each player begins with.
	details = "",
	-- This is so if they rejoin they are still in jail.
	arrested = false,
	-- Donator time.
	donator = 0,
	-- Gender.
	gender = "Male",
	-- Used to block players from certain jobs and whatnot, don't touch it.
	blacklist = {},
	-- Used to store items, don't touch it.
	inventory = {},
	-- Used for IC chat and stuff.
	rpname = "",
}
