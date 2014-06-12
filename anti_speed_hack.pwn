//==============================================================================
#include 									<a_samp>
//==============================================================================
main( ){}

new PlayerName [ MAX_PLAYERS ] [ MAX_PLAYER_NAME ] ;
new Float:vehicle_health [ MAX_PLAYERS ];
//==============================================================================
public OnPlayerConnect(playerid)
{
	GetPlayerName ( playerid, PlayerName [ playerid ] , MAX_PLAYER_NAME ) ;
	return 1;
}
public OnPlayerUpdate ( playerid )
{
    if ( GetPlayerState ( playerid ) == PLAYER_STATE_DRIVER )
    {
        static speed_player [ MAX_PLAYERS ] ;
        new veh_id = GetPlayerVehicleID( playerid ),Float:veh_health_now;
        GetVehicleHealth(veh_id,veh_health_now);
        if ( GetPlayerSpeed ( playerid ) - speed_player [ playerid ] > 20 && veh_health_now - vehicle_health [ playerid ] == 0 )
        {
			AntiCheatMessage(playerid, "Speed Hack");
            return 1;
        }
        speed_player [ playerid ] = GetPlayerSpeed ( playerid ) ;
  		GetVehicleHealth(veh_id,vehicle_health [ playerid ]);
    }
    return 1;
}



stock GetPlayerSpeed ( playerid )
{
    new Float:x, Float:y, Float:z;
    GetVehicleVelocity ( GetPlayerVehicleID ( playerid ), x, y, z ) ;
    return floatround ( floatsqroot ( x * x + y * y + z * z ) * 295  ) ;
}
stock AntiCheatMessage ( playerid, reason [ ] )
{
	new string [ 128 ] ;
	format ( string, sizeof string, "[Guard System]%s[%d] was blocked. Reason: %s", PlayerName [ playerid ], playerid, reason ) ;
	SendClientMessageToAll (0xFF644BFF, string ) ;
	KickEx ( playerid ) ;
	return 1;
}

stock KickEx ( playerid )
{
	new ms = GetPlayerPing ( playerid ) > 200 ? 200 : GetPlayerPing ( playerid ) + 50 ;
	return SetTimerEx ( "MyKick", ms , 0, "i", playerid ) ;
}
forward MyKick ( playerid );
public MyKick ( playerid ) { Kick ( playerid ) ;}

