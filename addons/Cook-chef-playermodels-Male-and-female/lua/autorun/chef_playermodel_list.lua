--Used to import the player model into the player model list (context menu)
--ENJOY ^^

local function AddPlayerModel( name, model )

	list.Set( "PlayerOptionsModel", name, model )
	player_manager.AddValidModel( name, model )
	
end

AddPlayerModel( "Cook/chef male ", "models/fearless/chef1.mdl" )
AddPlayerModel( "Cook/chef female", "models/fearless/chef2.mdl" )
