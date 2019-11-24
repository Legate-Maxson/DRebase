/datum/round_event_control/meteor_wave/major_dust
	name = "Major Space Dust"
	typepath = /datum/round_event/meteor_wave/major_dust
	weight = 8
	gamemode_blacklist = list("dynamic")

/datum/round_event/meteor_wave/major_dust
	wave_name = "space dust"

/datum/round_event/meteor_wave/major_dust/announce(fake)
	var/reason = pick(
		"The station is passing through a debris cloud, expect minor damage \
		to external fittings and fixtures.",
		"Nanotrasen Superweapons Division is testing a new prototype \
		[pick("field","projection","nova","super-colliding","reactive")] \
		[pick("cannon","artillery","tank","cruiser","\[REDACTED\]")], \
		some mild debris is expected.",
		"A neighbouring station is throwing rocks at you. (Perhaps they've \
		grown tired of your messages.)")
	if(prob(50))
		priority_announce(pick(reason), "Collision Alert")
	else
		priority_announce("A report has been downloaded and printed out at all communications consoles.", "Incoming Classified Message", 'sound/ai/commandreport.ogg') // CITADEL EDIT metabreak
		for(var/obj/machinery/computer/communications/C in GLOB.machines)
			if(!(C.stat & (BROKEN|NOPOWER)) && is_station_level(C.z))
				var/obj/item/paper/P = new(C.loc)
				P.name = "Collision Alert"
				P.info = "[pick(reason)]"
				P.update_icon()