#include <sourcemod>
#include <sdktools>

#pragma semicolon 1
#pragma newdecls required

public Plugin myinfo =
{
	name = "Teleport to XYZ",
	author = "Infra",
	description = "Easily teleport to given co-ordinate.",
	version = "1.0",
	url = "https://github.com/1zc"
};

public void OnPluginStart()
{
    RegAdminCmd("sm_printxyz", Command_PrintXYZ, ADMFLAG_GENERIC, "Prints your current co-ordinates in console.");
    RegAdminCmd("sm_printloc", Command_PrintXYZ, ADMFLAG_GENERIC, "Prints your current co-ordinates in console.");
    RegAdminCmd("sm_tpto", Command_TeleportXYZ, ADMFLAG_GENERIC, "Teleport to given co-ordinates.");
    RegAdminCmd("sm_tp2", Command_TeleportXYZ, ADMFLAG_GENERIC, "Teleport to given co-ordinates.");
}

Action Command_PrintXYZ(int client, int args)
{
    float coordinates[3];
    GetEntPropVector(client, Prop_Send, "m_vecOrigin", coordinates);

    PrintToConsole(client, "-------------------\nCURRENT CO-ORDINATES: (X Y Z)");
    PrintToConsole(client, "%.2f %.2f %.2f\n", coordinates[0], coordinates[1], coordinates[2]);
    PrintToConsole(client, "-------------------");

    return Plugin_Handled;
}

Action Command_TeleportXYZ(int client, int args)
{
    char temp[12];
    int numOfArgs = GetCmdArgs();

    if (numOfArgs != 3)
    {
        PrintToChat(client, "\x01[\x02TP2XYZ\x01] \x02Please enter three arguments in the format: /tpto X Y Z");
        return Plugin_Handled;
    }

    else 
    {
        float coordinates[3], angle[3];
        for (int i = 0; i < 3; i++)
        {
            GetCmdArg(i+1, temp, sizeof(temp));
            coordinates[i] = StringToFloat(temp);
        }

        GetClientEyeAngles(client, angle);

        TeleportEntity(client, coordinates, angle, NULL_VECTOR);
        return Plugin_Handled;
    }
}