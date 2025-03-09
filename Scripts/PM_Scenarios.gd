extends Node

signal turn_off_input_processing_at_panel
signal turn_on_input_processing_at_panel

@onready var glob = get_node("/root/globals")
var text
@onready var Textbox = $"../Control/SubViewportContainer/SubViewport/Textbox"
@onready var Textbox2 = $"../Textbox"
@onready var CharSprite = $"../Control/SubViewportContainer/SubViewport/CharSprite"
@onready var ProtagonistName = glob.ProtagonistName
@onready var HanninName = glob.HanninName
@onready var stamps = $"..".stamps
@onready var CharScriptCG = $"../CG/CharSprite"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if glob.Save["PlayWildDialogue"] != null:
		wild_dialogue(glob.Save["PlayWildDialogue"])
		glob.Save["PlayWildDialogue"] = null
		
		
func playText(text):
	Textbox.playText(text)

func chat(chatter, message):
	$"..".chat(chatter, message)

func wild_dialogue(key : String):
	pass
	
func live_scenario(key : String):
	#
	#if !glob.isPanelMode:
		#return
	#
	
	if !$"..".visible:
		return
	
	print(key)
	
	if key == "panel_tutorial_1":
		glob.panel_scenario_is_playing = true
		$"..".AutoChat = false
		
		for i in range(10):
			rng_chat()
		
		natural_chat_player([
			"ロり汁ください | "+$"..".stamps["butt_1"],
			"ロり汁ください | "+$"..".stamps["ahegao_1"],
			"ロり汁ください | The stamps in this page are awesome! "+$"..".stamps["ahegao_2"]
		])
		
	
		Textbox.reset()
		CharSprite.changeExpression("surprised")
		CharSprite.clearBlush()
		text = [
			ProtagonistName+" | It's chat! This looks like YouPipe...",
			ProtagonistName+" | These guys aren't reliable but I should be able to get some information from them.",
			ProtagonistName+" | 「Guys! Can you hear me? What's going on?」",
		]
		playText(text)
		await Textbox.finished
		Textbox.reset()
		
		CharSprite.changeExpression("surprised")
		text = [
			HanninName+" | 「Well, well... It seems some chatters are still pretending to be decent people. Common guys, be honest, you all wanna see this bitch in shambles.」",
			HanninName+" | 「I'll be keeping her here for you guys pleasure for at least a whole week, police will not find this place before that!」",
		]
		playText(text)
		
		natural_chat_player([
			"ファットアッス | Riritan irl is so hot, i love you, just imagining you gettiiing raped gets me so hard! sorry",
			"可愛いくないフォックス | You are on the news. It was like \"Virtual celebrity kidnapped and being show on dark web streaming site\"",
			"JohnHicc | Please be safe, rescue is on the way!",
			"熊パンキング | The news channel said that police is investigating the kidnapping of a virtual youpiper, they didn't reveal your identity tho.",
			"可愛いくないフォックス | Police seems to be investigating without disclosing your personal information to the public."
			])
		
		await Textbox.finished
		Textbox.reset()
		CharSprite.changeExpression("thinking")
		
		
		playText(ProtagonistName+" | Thank god my identity didn't go all public! If I get out of here alive I might barely not die from embarrassement if I delete all my content...")
		await Textbox.finished
		CharSprite.changeBlush(1,1)
		
		
		playText(ProtagonistName+" | My family probably got notified about this situation tho... This is the worst...")
		await Textbox.finished
		
		CharSprite.changeBlush(1,0)
		CharSprite.changeExpression("sympathetic")
		
		playText(ProtagonistName+" | 「You guys are so reassuring... I'm counting on you.」")
		await Textbox.finished
		
		natural_chat_player([
			"ファットアッス | Force her to get naked!!! please I cant my dick gonna blow",
			"4545の達人 | Ok, I feel a little sorry for you, but I'm already typing with one hand...",
			"riritan_enjoyer101 | Please don't mind these degenerates, I will do anything for you my queen."
			])
			
		CharSprite.changeExpression("thinking")
		CharSprite.changeBlush(1,1)
		
		playText(ProtagonistName+" | All I can do is pray my family and friends aren't watching my youpipe archives while I'm stuck in here...")
		await Textbox.finished
		crude_chat_player(2)
		CharSprite.changeExpression("fretting")
		CharSprite.changeBlush(1,3)
		CharSprite.changeBlush(2,4)
		
		playText(ProtagonistName+" | I need to get out of here as fast as possible and stop them even if it kills me!")
		await Textbox.finished
		crude_chat_player(2)
		
		CharSprite.clearBlush()
		CharSprite.changeExpression("apologetic")
		CharSprite.changeBlush(1,1)
		
		playText(HanninName+" | 「Well, whoever wants this bitch to get out of here in one piece do be putting your money where your mouth is.」")
		await Textbox.finished
		playText(ProtagonistName+" | Hope these idiots have enough money left to pay for my ransom after buying that panties aroma...")
		await Textbox.finished
		crude_chat_player(2)
		CharSprite.clearBlush()
		CharSprite.changeExpression("frown")
		playText(HanninName+" | 「Miss "+ProtagonistName+", now listen carefully, this will decide if you leave this place in one piece.」")
		await Textbox.finished
		
		
		glob.Save["TempFlag"] = "highlight_requests"
		
		playText(HanninName+" | 「Tap the requests button.」")
		
		natural_chat_player([
			"doutei_43sai | Please take my virginity!",
			"SexatronMax | When is the promised lewd shit happening??? Feeling scammed right now! "+$"..".stamps["ahegao_4"],
			"Ret_Ihweb | Your skin is so white, I think I'm in love!"
			])
		
		await Textbox.finished
		playText(ProtagonistName+" | I should obey for now, need to gather more information...")
		await Textbox.finished
		return
	
	if key == "panel_tutorial_2":
		Textbox2.reset()
		text = [
			HanninName+" | 「Here is your only way to make money. Requests made by viewers will be displayed here, accepting or denying them is up to you. But you must not ignore them, it's a bad business practice! hahaha」",
			HanninName+" | 「But do not forget that a terrible punishment awaits for you if you do not earn the requested amount within the next 7 days...」",
			HanninName+" | 「Of course, I actually expect you to fail, can't wait to punish you mufufu...」",
			ProtagonistName+" | Don't even want to imagine what this sicko is gonna do to me... Need to get out of here somehow.",
			HanninName+" | 「Well, this is all you need to know, now use that vulgar body of yours to make me some money! I'll be watching... Byeee!」",
		]
		Textbox2.playText(text)
		await Textbox2.finished
		glob.panel_scenario_is_playing = false
		$"..".AutoChat = true
		return
	
	if key == "day2_opening":
		glob.panel_scenario_is_playing = true
		$"..".AutoChat = false
		CharSprite.changeExpression("d_smile")
		CharSprite.clearBlush()
		playText(ProtagonistName+" | 「Good morning guys! Though I can't really tell if it's morning from here! hahaha」")
		
		natural_chat_player([
			get_random_name_from_group("gatikoi_en")+" | Good morning! You look so pretty even after just waking up.",
			"Vote4TrumpMAGA | It is unfortunate that you live in Japan, president Trump would never allow something like this to happen...",
			get_random_name_from_group("gatikoi_en")+" | Good morning. Hope you're doing well...",
			"KILL_ALL_JEWS | DEATH TO AMERICA! AND FUCK THE JEWS!!!",
		])
		await Textbox.finished
		CharSprite.changeExpression("thinking")
		playText("Never imagined that loosing my power to ban people would be so painful...")
		await Textbox.finished
		CharSprite.changeExpression("neutral")
		playText(ProtagonistName+" | 「Guys, how are the news? Anything about me?」")
		natural_chat_player([
			"可愛いくないフォックス | Nothing new, just a mention that the police is on the case.",
			"LanaButBackwards | My nickname is awesome, but it's backwards.",
			"熊パンキング | The media is useless, but some youpipers are digging information about this YouKai site, it seems you are the fourth girl they kidnap.",
			"Kodyn88 | It seems you are the first famous person they kidnap, I guess kidnapping regular girls wasn't that profitable...",
		],2)
		await Textbox.finished
		CharSprite.changeExpression("thinking")
		playText("So I'm not the first to be put in this room... It means that police failed to find it in time in at least three different occasions and gave up...")
		await Textbox.finished
		playText("Still, since I'm a YouPiper they will put some extra effort in recuing me, probably...")
		await Textbox.finished
		playText(ProtagonistName+" | 「Anyone knows what happened to the girls who were kidnapped before me?」")
		
		natural_chat_player([
			"EpsteinsClient | I know one of them was sold as a sex slave after failing to reach the goal, I still have her in my island villa. \n"+$"..".stamps["wasted_1"],
			"Kodyn88 | It seems that all of them failed to reach the ransom goal and were then put for sale. Not a single one was found, though this operation seems to have been going on for only about one year...",
			"doutei_43sai | EpsteinsClient-sama, can you please lend her to me for one hour? I beg!!!",
			"N07_N1663R | I watched the show last time, after she failed to meet the deadline the girl was raped and tortured on camera and then sold off as a sex slave. Felt kinda bad for her but duuuude, it was hot!",
			"riritan_enjoyer101 | Don't worry, with our love and support you'll reach the ransom goal in no time",
		])
		await Textbox.finished
		CharSprite.changeExpression("thinking")
		CharSprite.togFaceGloom(true)
		playText("...")
		await Textbox.finished
		CharSprite.togFaceGloom(false)
		playText("Think my face turned blue for a moment there... If what these chatters are saying is true...")
		await Textbox.finished
		playText("One bad decision and my life will truly be over...")
		await Textbox.finished
		CharSprite.changeExpression("sympathetic2")
		CharSprite.changeBlush(1,1)
		playText(ProtagonistName+" | 「Guys, you like me right? You don't wanna see me get violated and sold to some weird old men right? So... Can you guys please help me reach the ransom goal? I love you guys.」")
		await Textbox.finished
		natural_chat_player([
			"OnlyRiritan | I'll do what I can to pay the ransom even if it means sacrificing my butthole in a fag club.",
			"Ret_Ihweb | We must come together and protect her! If she gets raped too much the skin down there might become less white",
			"CatPerson42 | I love you. Will do what I can to help",
			"KingOfSimps77 | I'm low on money because I bought 20 flasks of the \"Panty Aroma\", sorry. I'll gather what I can, even if I starve to death I'll do my best for you.",
			"ファットアッス | Guys wait a bit... I think I'm cooking here... Yeah, if she fails we can come together and buy her for ourselves!",
			])
		CharSprite.changeExpression("d_smile")
		CharSprite.clearBlush()
		playText(ProtagonistName+" | 「I knew I could count on you guys, thank you for all the support!」")
		await Textbox.finished
		playText("Thank god these guys are so stupid.")
		await Textbox.finished
		CharSprite.changeExpression("surprised")
		playText(HanninName+" | 「Bunch of morons! I intended to just enjoy the show, but it's impossible! You guys must be truly retarded huh.」")
		await Textbox.finished
		CharSprite.changeExpression("d_smug")
		playText(ProtagonistName+" | 「So you get angry when things aren't going the way you want huh, how cute...」")
		await Textbox.finished
		playText(HanninName+" | 「Shut up you fucking whore, just got you muted, try to interrupt me now bitch!」")
		natural_chat_player([
			"KingOfSimps77 | How dare you talk to our queen like that you scumbag!",
			"RectumInvader69 | Hell yeah! Put this bitch in her due place!",
			"ファットアッス | you are hot even when getting yelled at, i got hard again",
			"Kodyn88 | This is no way to speak to such a perfect and lovely girl!",
			"Vote4TrumpMAGA | If you were in America President Trump would get you executed for this you pile of shit!",
			"Ret_Ihweb | THIS IS A BLACK WORK ENVIRONMENT! NOT GOOD!!!",
			"FreePalestine | Outside of America your white privilege means nothing! Give this white skinned karen what she deserves!",
			])
		await Textbox.finished
		CharSprite.changeExpression("angry_2")
		playText(HanninName+" | 「This girl is lying to you dimwits! Wake up! She doesn't even like you morons!」")
		natural_chat_player([
			"diaper_sandwich | Liar! Riritan is not that type of person! She loves me!",
			"chicken_deepfry | Yeah, like hell I'm believing a kidnapper!",
			"OnlyRiritan | No matter what you say I'm on her side till death do us part!",
			"KingOfSimps77 | Such a beaultiful and perfect girl would never lie to her fans who are willing to die for her!",
			])
		await Textbox.finished
		playText(HanninName+" | 「She's not even a virgin you morons! Yeah, that's right, I stripped her naked and took a look at it while she was unconcious, HER HYMEN IS DAMAGED!!!」")
		natural_chat_player([
		"crispy_sausage89 | Liar! She said her fans would always be the only one in her heart!!!",
		"Ret_Ihweb | I don't really care as long as it was taken by a white dude!",
		"doutei_43sai | There's no way a girl her age isn't virgin! I'm 43 years old and still a virgin!",
		"riritan_enjoyer101 | If she says she's virgin then she's virgin!",
		"diaper_sandwich | She would never have sex before marriage, she's the most rightous person on earth!",
		"ファットアッス | Liar! If you want us to believe you then force her to get naked and show the insides of her pussy right now!",
		])
		await Textbox.finished
		CharSprite.changeExpression("surprised")
		CharSprite.changeBlush(1,2)
		playText(HanninName+" | 「Don't believe? Well, I actually took a photo with my phone, look closely!」")
		await Textbox.finished
		CharSprite.changeExpression("fretting")
		CharSprite.changeBlush(1,2)
		playText(HanninName+" | 「Now, with the thuth on your faces, it's time to get revenge! Force this bitch to humiliate herself till she's as miserable as you morons! I'll go back to just watching, byeeee!」")
		$"..".push_chat()
		$"../ChatControl/Chat/s1/RichTextLabel".text = "pussy goes in here"
		natural_chat_player([
		"KingOfSEXO | OMG, THIS IS SO HOT",
		"crispy_sausage89 | No... It can't be... Did you lie to us? Did you have a boyfriend all along???",
		"OnlyRiritan | NO!NO!NO!NOO it cant beee I think i'll kill myself",
		"ReinBohr | God... I think I'll throw up, this is too much to process...",
		"MassDeportationEnjoyer | This is terrible, doing such a thing before marriage...",
		"riritan_enjoyer101 | This is so sad... Why did you lie to us? We would have accepted you no matter what T.T",
		"ファットアッス | This is unforgivable! How dare you deceive us all!!! We need to make sure she gets humiliated and raped in all possible ways! Dang, I just came all over my keyboard again",
		"only_natsuki | This is why I will always put Natsuki first, she is pure! But you're still second place in my heart "+ProtagonistName,
		"GeorgeFloyder_BLM | THIS IS WHAT YOU FUCKERS GET FOR TRUSTING A WHITE BITCH, GET FUCKEEEEDDDD!!!",
		
		])
		await Textbox.finished
		CharSprite.changeBlush(1,3)
		CharSprite.changeBlush(2,1)
		CharSprite.changeBlush(3,4)
		playText(ProtagonistName+" | 「Kyaaa! Don't look!」")
		await Textbox.finished
		playText("It's over... It's so over, what do I do now? Wonder if there's a rope in the shop, wait, no place to tie it either...")
		await Textbox.finished
		playText("If only not for that terrible accident there would still be hope...")
		await Textbox.finished
		playText("Yes, that day at school that ended up with that \"thing\" shoved all the way inside me... It all happened one year ago...")
		await Textbox.finished
		
		glob.holdImage = get_viewport().get_texture().get_image()
		$"..".add_child(load("res://Scenes/scene_transition.tscn").instantiate())
		
		$"../CG".visible = true
		
		CharScriptCG.moveTo("middle")
		CharScriptCG.changeExpression("d_smile")
		var previousClothes = glob.Save["Clothes"]
		glob.Save["Clothes"] = {"BehindBody" : null, "BaseBody" : null, "Booba" : null, "Pubic_hair" : null, "OnePieceUnderwear" : null, "Bra" : "underwear_v1_bra_blue", "Panty" : "underwear_v1_panty_blue", "OnePiece" : "school_uniform_bare_legs", "Top" : null, "Bot" : null, "Accessory" : null, "Accessory2" : null, "Accessory3" : null}
		playText(ProtagonistName+" | 「Saki-chan, what are we going to sculpt today?」")
		
		await Textbox.finished
		playText("Saki-chan | 「Actually there's something I've been wanting to make with you for a while now! Since the other club members already went home, today we can make it...」")
		await Textbox.finished
		playText("Saki-chan is acting a little weird... Wonder what she's planning to sculpt.")
		await Textbox.finished
		CharScriptCG.changeExpression("troubled")
		playText(ProtagonistName+" | 「So, what exactly are we making?」")
		await Textbox.finished
		playText("Saki-chan | 「It's hard to explain. Let's make it first, questions later!」")
		await Textbox.finished
		playText("Well, the curiosity easily overcame the weird feeling...")
		await Textbox.finished
		CharScriptCG.changeExpression("d_smile")
		playText(ProtagonistName+" | 「Okay then, what shapes should I make?」")
		await Textbox.finished
		playText("Saki-chan | 「For now, make two spheres, It's fine to be crude, I'll refine then!」")
		await Textbox.finished
		playText("And so we got our hand into the clay. Wonder what we are making tho...")
		await Textbox.finished
		playText("Saki-chan | 「Yuka-chan, when did your family move from Europe to Japan? Is your English really fluent?」")
		await Textbox.finished
		playText(ProtagonistName+" | 「It was when I was seven I guess.」")
		await Textbox.finished
		CharScriptCG.changeExpression("d_smug2")
		playText(ProtagonistName+" | 「I still talk in English with my parents sometimes, so yeah, I might just about speak fluent English, not that it makes me incredible or anything...」")
		await Textbox.finished
		playText("Saki-chan | 「Your expression contradicts your words... But feel free to brag to me, I really enjoy having a beautiful and talented friend!」")
		await Textbox.finished
		CharScriptCG.changeBlush(1,2)
		CharScriptCG.changeExpression("embarrassed")
		playText("I feel my face getting hot... She knew this would happen and did it on purpose... Again that is...")
		await Textbox.finished
		CharScriptCG.changeExpression("shy2")
		playText(ProtagonistName+" | 「Can you please stop making me blush for your own enjoyment?」")
		await Textbox.finished
		playText("Saki-chan | 「Nope, it's just too much fun. Will keep doing it at every opportunity, deal with it.」")
		await Textbox.finished
		CharScriptCG.changeBlush(1,1)
		CharScriptCG.changeExpression("angry2")
		playText(ProtagonistName+" | 「You little...」")
		await Textbox.finished
		playText("Well, she is my best friend and if I asked more seriously she would stop doing it, probably...")
		await Textbox.finished
		CharScriptCG.changeExpression("d_smug")
		CharScriptCG.clearBlush()
		playText(ProtagonistName+" | 「Okay, I shall forgive you this time... Again...」")
		await Textbox.finished
		playText("Saki-chan | 「Thank you very much! Did you finish making the bal... I mean, spheres?」")
		await Textbox.finished
		CharScriptCG.changeExpression("d_smile")
		playText(ProtagonistName+" | 「Just finished! I see you made some sort of curvy pole, what are you making with these anyways?」")
		await Textbox.finished
		playText("Saki-chan | 「Wait and see... I'll just put these together and refine a little...」")
		await Textbox.finished
		playText(ProtagonistName+" | 「Hey, what are you doing there, let me see!!」")
		await Textbox.finished
		playText("Saki-chan | 「Not yet! Needs a little more detail on the tip and... Some veins here...」")
		await Textbox.finished
		CharScriptCG.changeExpression("thinking")
		playText("Did she just say veins? What the heck is she making...")
		await Textbox.finished
		CharScriptCG.changeExpression("fired_up")
		playText(ProtagonistName+" | 「Okay, I'm all out of patience, I'm seeing it one way or another!」")
		await Textbox.finished
		playText("Saki-chan | 「Too late! Hyaaaaaa」")
		await Textbox.finished
		CharScriptCG.changeExpression("surprised")
		playText("She shoved it inside the plastification machine before I could take a look!")
		await Textbox.finished
		CharScriptCG.changeExpression("frantic")
		playText(ProtagonistName+" | 「... Okay, my loss」")
		await Textbox.finished
		CharScriptCG.changeExpression("sympathetic2")
		playText(ProtagonistName+" | 「Can you please tell me what it is Saki-sama.」")
		await Textbox.finished
		playText("Saki-chan | 「Not yet! The plastification will only take a minute, sit and wait!」")
		await Textbox.finished
		CharScriptCG.changeExpression("arrogant2")
		playText(ProtagonistName+" | 「It better be something worth all this suspense. Won't forgive you if it's boring!」")
		await Textbox.finished
		playText("Saki-chan | 「Relax, it's a creative masterpiece, I swear!」")
		await Textbox.finished
		playText(ProtagonistName+" | 「Last time you said that you had sculpted that weird banana...」")
		await Textbox.finished
		playText("Saki-chan | 「My skills greatly improved since then, this time is for real!」")
		await Textbox.finished
		playText("Saki-chan | 「It's done! Let's get it out of the plastification machine together!」")
		await Textbox.finished
		CharScriptCG.changeExpression("fired_up")
		playText("Finally. My curiosity will be sated!")
		await Textbox.finished
		playText("Saki-chan | 「Okay, let's open the machine in 3... 2...」")
		await Textbox.finished
		playText("It's finally the moment!")
		await Textbox.finished
		playText("Saki-chan | 「Annnnd... Ta-da!」")
		await Textbox.finished
		CharScriptCG.changeExpression("surprised")
		CharScriptCG.changeBlush(1,2)
		playText(ProtagonistName+" | 「OH MY GOD!」")
		await Textbox.finished
		playText("... It's so big and veiny")
		await Textbox.finished
		CharScriptCG.changeExpression("fretting")
		CharScriptCG.changeBlush(1,3)
		CharScriptCG.changeBlush(2,4)
		playText(ProtagonistName+" | 「W, wh, what were you thinking!? Making such a...」")
		await Textbox.finished
		playText(ProtagonistName+" | 「In school at that, what if a teacher sees this... \"thing\"? We would never hear the end of it!」")
		await Textbox.finished
		playText("Saki-chan | 「Relax, a teacher never entered into the art clubroom. That aside, doesn't it look awesome?!」")
		await Textbox.finished
		playText(ProtagonistName+" | 「It does...nt! Such a hideous shape...」")
		await Textbox.finished
		playText("Saki-chan | 「Common, you don't need to be shy around me, and it's only natural for girls to find this \"shape\" fascinating! And it's funny too!」")
		await Textbox.finished
		playText("She seems to be trying to contain her laugher, but she's failling miserably at that...")
		await Textbox.finished
		playText("Saki-chan | 「Hahahahahaha, I can't hold it, hahaha, this is so funny! Hahaha」")
		await Textbox.finished
		playText("She seems to think she's a master comedian right now...")
		await Textbox.finished
		CharScriptCG.changeExpression("troubled")
		CharScriptCG.changeBlush(2,0)
		CharScriptCG.changeBlush(1,2)
		playText(ProtagonistName+" | 「What do you intend to do with this \"thing\"?」")
		await Textbox.finished
		playText("Saki-chan | 「I didn't think that far ahead, tehee.」")
		await Textbox.finished
		playText(ProtagonistName+" | 「Figured as much...」")
		await Textbox.finished
		playText("Saki-chan | 「I'm most certaily not getting rid of it, it's the best piece of art I ever made!」")
		await Textbox.finished
		playText(ProtagonistName+" | 「So... You're taking this home? Don't you have a little sister and parents? What if someone finds it?」")
		await Textbox.finished
		playText("Saki-chan | 「Didn't think that far ahead...」")
		await Textbox.finished
		playText("Saki-chan | 「Eureka! I got an idea, your parents don't enter your room right? So what if y」")
		await Textbox.finished
		CharScriptCG.changeBlush(1,1)
		CharScriptCG.changeExpression("angry2")
		playText(ProtagonistName+" | 「Absolutely not!」")
		await Textbox.finished
		playText("Saki-chan | 「Please! Just till I grow up and get my own place, I beg!!! I'll do anything!」")
		await Textbox.finished
		playText("She's even got tears in her eyes... Does this \"thing\" means that much to her?")
		await Textbox.finished
		playText("Saki-chan | 「We made it together, it's like a symbol of our friendship...」")
		await Textbox.finished
		playText("Oh no, my female brain is making me feel empathy for her... I can't stop myself from getting emotional... Dammit!")
		await Textbox.finished
		CharScriptCG.changeExpression("sympathetic")
		playText(ProtagonistName+" | 「Fine... you win...」")
		await Textbox.finished
		playText("Saki-chan | 「Yay, I win again, I'm so glad you're my friend!」")
		await Textbox.finished
		CharScriptCG.changeExpression("frown")
		playText(ProtagonistName+" | 「You should shut up before I change my mind...」")
		await Textbox.finished
		playText("Saki-chan | 「Got it!」")
		await Textbox.finished
		CharScriptCG.changeExpression("embarrassed")
		CharScriptCG.changeBlush(1,2)
		playText(ProtagonistName+" | 「Can you come to my place today? I really don't wanna touch it...」")
		await Textbox.finished
		playText("Saki-chan | 「I'll need to take care of my little sister today...」")
		await Textbox.finished
		playText("Saki-chan | 「Common, it won't bite you, it's not even the real thing! Here goes nothing! Hey-yaa」")
		await Textbox.finished
		CharScriptCG.changeExpression("surprised")
		playText(ProtagonistName+" | 「Nah!」")
		await Textbox.finished
		playText("Saki-chan threw the \"thing\" at me and I instinctively grabbed it with my bare hands!")
		await Textbox.finished
		CharScriptCG.changeExpression("fretting")
		CharScriptCG.changeBlush(1,3)
		CharScriptCG.changeBlush(2,4)
		playText(ProtagonistName+" | 「Kyaaa!」")
		await Textbox.finished
		playText("Saki-chan | 「You can't stay a virgin forever, use this opportunity to get used to it!」")
		await Textbox.finished
		playText(ProtagonistName+" | 「W, w, what? Weren't you a virgin too?」")
		await Textbox.finished
		playText("Saki-chan | 「Well, yes... But this is irrelevant! Girls who don't fetch a good men turn into sad and lame cat ladies! It's a destiny worst than death itself!」")
		await Textbox.finished
		CharScriptCG.changeExpression("shy")
		CharScriptCG.changeBlush(2,0)
		CharScriptCG.changeBlush(1,2)
		playText("I like cats... But I also can't deny the truth in her words...")
		await Textbox.finished
		CharScriptCG.changeExpression("insecure")
		playText(ProtagonistName+" | 「Ok, I can't disagree with you on this one... But, this \"thing\" feels so grotesque and weird... And it's still lukewarm from the plastification too, just ew!」")
		await Textbox.finished
		playText("Saki-chan | 「You bet I'm right! Now, try giving it a nice hawk tuah!」")
		await Textbox.finished
		CharScriptCG.changeExpression("troubled")
		playText(ProtagonistName+" | 「What does that even mean?」")
		await Textbox.finished
		playText("Saki-chan | 「You're better off not knowing...」")
		await Textbox.finished
		CharScriptCG.changeBlush(1,1)
		playText(ProtagonistName+" | 「Do you even know what it means?」")
		await Textbox.finished
		playText("Saki-chan | 「Not at all... I've just seen some people online using it kinda like that.」")
		await Textbox.finished
		playText(ProtagonistName+" | 「Please don't just go around repeating weird stuff you don't even know the meaning of...」")
		await Textbox.finished
		playText("Saki-chan | 「Understood mom!」")
		await Textbox.finished
		playText("Saki-chan | 「I need to go to the toilet. Let's eat some cake on the way back!」")
		await Textbox.finished
		CharScriptCG.clearBlush()
		CharScriptCG.changeExpression("d_smile")
		playText(ProtagonistName+" | 「Sure... But I think I'll be really uncomfortable walking around with this thing on my bag tho... Let's keep it short.」")
		await Textbox.finished
		playText("Saki-chan | 「Okay, be right back.」")
		await Textbox.finished
		CharScriptCG.changeExpression("neutral")
		playText("At least it never gets boring with her around.")
		await Textbox.finished
		playText("Still, she sure got good at sculpting hum... When I look closely I can tell that it's actually very well made...")
		await Textbox.finished
		CharScriptCG.changeExpression("embarrassed")
		CharScriptCG.changeBlush(1,1)
		playText("It's so manly and detailed, it would look real if painted with skin color...")
		await Textbox.finished
		playText("So many veins popping... It looks painful... Makes me wonder what men feel when it's full of blood...")
		await Textbox.finished
		CharScriptCG.changeBlush(1,2)
		playText("Would something like this really fit inside a girl? Could this be bigger than the real thing?")
		await Textbox.finished
		playText("If this were to fit inside it would probably be really tight...")
		await Textbox.finished
		CharScriptCG.changeBlush(1,3)
		playText("It would rub all sides and reach really deep... Would probably feel incred...")
		await Textbox.finished
		CharScriptCG.changeExpression("fretting")
		playText("Wait... What am I thinking?")
		await Textbox.finished
		CharScriptCG.changeExpression("embarrassed")
		playText("What if I were to press it against my panties right now? ...")
		await Textbox.finished
		playText(ProtagonistName+" | 「Ulp!」")
		await Textbox.finished
		playText("I'll just press it against my underwear a little bit and that's it...")
		await Textbox.finished
		playText("Doki-doki")
		await Textbox.finished
		playText("It feels so kinda good... Wonder how it feels if touched directl..")
		await Textbox.finished
		playText("Saki-chan | 「I'M BACK!!! Ah...」")
		await Textbox.finished
		CharScriptCG.changeExpression("surprised")
		playText(ProtagonistName+" | 「Kyaaaaaaaaa!!!」")
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	
	
	
	if key == "Feet is the best part of woman!_accept":
		glob.panel_scenario_is_playing = true
		$"..".AutoChat = false
		Textbox2.reset()
		text = [
			ProtagonistName+" | Feet... Well, all things considered this freak's request is no big deal...",
			ProtagonistName+" | Still... Just how much of a weirdo freak one must be to pay 200$ to see feet...",
		]
		Textbox2.playText(text)
		await Textbox2.finished
		CharSprite.changeExpression()
		$"../NavyButtons/Live".pressed.emit()
		
	if key == "Feet is the best part of woman!_deny":
		pass
		
		
func rng_chat():
	$"..".push_chat()
	$"../ChatControl/Chat/s1/RichTextLabel".text = $"..".filler_message_generator()
	

func crude_chat_player(amount : int, timerMin = 0.8, timerMax = 1.6):
	var rng = RandomNumberGenerator.new()
	for i in range(amount):
		await get_tree().create_timer(rng.randi_range(timerMin,timerMax)).timeout
		$"..".push_chat()
		$"../ChatControl/Chat/s1/RichTextLabel".text = $"..".filler_message_generator()
		
	
func natural_chat_player(chat : Array, delay = 0, timerMin = 0.8, timerMax = 1.6):
	await get_tree().create_timer(delay).timeout
	var rng = RandomNumberGenerator.new()
	var s
	for i in chat:
		await get_tree().create_timer(rng.randi_range(timerMin,timerMax)).timeout
		s = i.split(" | ")
		chat(s[0], s[1])
		
	
func get_random_name_from_group(group : String):
	var perverts = [
		"[b][color=#DC143C]SexatronMax[/color]: [/b]",
		"[b][color=#8B0000]KingOfSEXO[/color]: [/b]",
		"[b][color=#FFC0CB]wooden_horsie[/color]: [/b]",
		"[b][color=#FFFF00]LiteralFucker[/color]: [/b]",
		"[b][color=#FFD700]iHateGays[/color]: [/b]",
		"[b][color=#006400]inside__asshole[/color]: [/b]",
		"[b][color=#FFEBCD]AverageCoomer[/color]: [/b]",
		"[b][color=#F5F5DC]hotStinkyCoom[/color]: [/b]",
		"[b][color=#FFF8DC]plsdrinkmahcoom[/color]: [/b]",
		"[b][color=#7FFF00]BootaLickah69[/color]: [/b]",
		"[b][color=#6495ED]booba_enjoyer69[/color]: [/b]",
		"[b][color=#800000]JackTheRaper[/color]: [/b]",
		"[b][color=#C71585]SEXOmaster[/color]: [/b]",
		"[b][color=#FFDEAD]iAteUrMum[/color]: [/b]",
		"[b][color=#FFA500]milf_enjoyer[/color]: [/b]",
		"[b][color=#4169E1]Joe_Sniffer[/color]: [/b]",
		"[b][color=#DB7093]YourMomsUnderwear[/color]: [/b]",
		"[b][color=#808000]23cmPeenOwner[/color]: [/b]",
		"[b][color=#DAA520]MaximusSchlonger[/color]: [/b]",
		"[b][color=#7CFC00]your_daddy69[/color]: [/b]",
		"[b][color=#FFB6C1]LanaButBackwards[/color]: [/b]",
		"[b][color=#FFA07A]RectumInvader69[/color]: [/b]",
		"[b][color=#FFEFD5]KILL_ALL_JEWS[/color]: [/b]",
		"[b][color=#2E8B57]hitler_was_right[/color]: [/b]",
		"[b][color=#FF6347]Pedo4Life69[/color]: [/b]",
		"[b][color=#008000]FreePalestine[/color]: [/b]",
		"[b][color=#D2B48C]skankhunt45[/color]: [/b]",
		"[b][color=#008080]pussycrusher6900[/color]: [/b]",
		"[b][color=#A52A2A]N07_N1663R[/color]: [/b]",
		"[b][color=#D8BFD8]iLickPussies6969[/color]: [/b]",
		"[b][color=#F5DEB3]ihavenopantsonttv[/color]: [/b]",
		"[b][color=#00FF7F]JunkIsHot[/color]: [/b]",
		"[b][color=#FF69B4]groom_zah_children[/color]: [/b]",
		"[b][color=#ADFF2F]DragPeen4Kids[/color]: [/b]",
		"[b][color=#F0FFF0]slow_coomer[/color]: [/b]",
		"[b][color=#E6E6FA]premature_coomer[/color]: [/b]",
		"[b][color=#EE82EE]Dildoman[/color]: [/b]",
		"[b][color=#32CD32]hornygoblin[/color]: [/b]",
		"[b][color=#00FA9A]MidgetPenis[/color]: [/b]",
		"[b][color=#FFE4B5]ProCocker55[/color]: [/b]",
		"[b][color=#AFEEEE]42yo_virgin[/color]: [/b]",
		"[b][color=#FF00FF]SexMachine88[/color]: [/b]",
		"[b][color=#CD853F]TheCuckHimself[/color]: [/b]",
		"[b][color=#4B0082]bitch_killer690[/color]: [/b]",
		"[b][color=#00BFFF]EpsteinsClient[/color]: [/b]",
		"[b][color=#1E90FF]PedoPete[/color]: [/b]",
		"[b][color=#A52A2A]dungeater[/color]: [/b]",
		"[b][color=#00FF7F]LickerOfToes[/color]: [/b]",
	]
	var gatikois_en = [
		"[b][color=#DC143C]JohnHicc[/color]: [/b]",
		"[b][color=#8B0000]Vote4TrumpMAGA[/color]: [/b]",
		"[b][color=#FFC0CB]KingOfSimps77[/color]: [/b]",
		"[b][color=#FFFF00]only_xx[/color]: [/b]",
		"[b][color=#FFD700]crispy_sausage89[/color]: [/b]",
		"[b][color=#006400]AtomicThumb98[/color]: [/b]",
		"[b][color=#FFEBCD]moolampy[/color]: [/b]",
		"[b][color=#F5F5DC]ReinBohr[/color]: [/b]",
		"[b][color=#FFF8DC]riritan_enjoyer101[/color]: [/b]",
		"[b][color=#7FFF00]OnlyRiritan[/color]: [/b]",
		"[b][color=#6495ED]Ret_Ihweb[/color]: [/b]",
		"[b][color=#800000]IxyFox0[/color]: [/b]",
		"[b][color=#C71585]RedButtedMonkey[/color]: [/b]",
		"[b][color=#FFDEAD]slothixus[/color]: [/b]",
		"[b][color=#FFA500]professional_napper85[/color]: [/b]",
		"[b][color=#4169E1]Mp5_SZ[/color]: [/b]",
		"[b][color=#DB7093]ZaBigass[/color]: [/b]",
		"[b][color=#808000]diaper_sandwich[/color]: [/b]",
		"[b][color=#DAA520]CheapExpensiveVase[/color]: [/b]",
		"[b][color=#7CFC00]Kodyn88[/color]: [/b]",
		"[b][color=#FFB6C1]Ymen68[/color]: [/b]",
		"[b][color=#FFA07A]SwearItWastMe[/color]: [/b]",
		"[b][color=#FFEFD5]shroom_soup[/color]: [/b]",
		"[b][color=#2E8B57]MellowApple[/color]: [/b]",
		"[b][color=#FF6347]fluffy_doggo101[/color]: [/b]",
		"[b][color=#008000]CatPerson42[/color]: [/b]",
		"[b][color=#D2B48C]doggyturd4[/color]: [/b]",
		"[b][color=#008080]Turtle_Pie02[/color]: [/b]",
		"[b][color=#D8BFD8]sexy_robot00[/color]: [/b]",
		"[b][color=#F5DEB3]LoliLover690[/color]: [/b]",
		"[b][color=#00FF7F]MassDeportationEnjoyer[/color]: [/b]",
		"[b][color=#FF69B4]jc_kp442[/color]: [/b]",
		"[b][color=#ADFF2F]stinky_migrant[/color]: [/b]",
		"[b][color=#F0FFF0]mexican_otaku74[/color]: [/b]",
		"[b][color=#E6E6FA]MrSlimeyWackey[/color]: [/b]",
		"[b][color=#EE82EE]CommiesMustDie[/color]: [/b]",
		"[b][color=#32CD32]SuperDuperSomething[/color]: [/b]",
		"[b][color=#00FA9A]chicken_deepfry[/color]: [/b]",
		"[b][color=#FFE4B5]cringeASF[/color]: [/b]",
		"[b][color=#AFEEEE]MahNeymi[/color]: [/b]",
		"[b][color=#FF00FF]miaumiau55[/color]: [/b]",
		"[b][color=#CD853F]Yenomon[/color]: [/b]",
	]
	var gatikois_jp = [
		"[b][color=#DC143C]ネットおじたん[/color]: [/b]",
		"[b][color=#8B0000]ア君[/color]: [/b]",
		"[b][color=#FFC0CB]せいちゃん[/color]: [/b]",
		"[b][color=#FFFF00]Tanuki[/color]: [/b]",
		"[b][color=#FFD700]IkaYakiMaster[/color]: [/b]",
		"[b][color=#006400]NekoNyanNko[/color]: [/b]",
		"[b][color=#FFEBCD]OnigiriShokunin[/color]: [/b]",
		"[b][color=#F5F5DC]NegitamaDon[/color]: [/b]",
		"[b][color=#FFF8DC]おでんやのおやじ[/color]: [/b]",
		"[b][color=#7FFF00]TakoyakiMania[/color]: [/b]",
		"[b][color=#6495ED]しろくまカレー[/color]: [/b]",
		"[b][color=#800000]ChikuwaBunko[/color]: [/b]",
		"[b][color=#C71585]Mikan-gumi[/color]: [/b]",
		"[b][color=#FFDEAD]Nekofunjya[/color]: [/b]",
		"[b][color=#FFA500]猫になってみたい人さん[/color]: [/b]",
		"[b][color=#4169E1]イチゴジャムおじ[/color]: [/b]",
		"[b][color=#DB7093]おばあちゃんのとうもろこし[/color]: [/b]",
		"[b][color=#808000]天竜座の人[/color]: [/b]",
		"[b][color=#DAA520]夢に出てくるカエルさん[/color]: [/b]",
		"[b][color=#7CFC00]お化けカボチャ[/color]: [/b]",
		"[b][color=#FFB6C1]一人ぼっちの熊さん[/color]: [/b]",
		"[b][color=#FFA07A]ちいさなてんとう虫さん[/color]: [/b]",
		"[b][color=#FFEFD5]いちごショートケーキ[/color]: [/b]",
		"[b][color=#2E8B57]おばあちゃんの大根[/color]: [/b]",
		"[b][color=#FF6347]一つの卵さん[/color]: [/b]",
		"[b][color=#008000]苺おじさん[/color]: [/b]",
		"[b][color=#D2B48C]黒猫のおやつ[/color]: [/b]",
		"[b][color=#008080]ジャガメロンさん[/color]: [/b]",
		"[b][color=#D8BFD8]ゆめみるく[/color]: [/b]",
		"[b][color=#F5DEB3]ひらがなもじっこさん[/color]: [/b]",
		"[b][color=#00FF7F]水早江さん[/color]: [/b]",
		"[b][color=#FF69B4]青い鳥さん[/color]: [/b]",
		"[b][color=#ADFF2F]猫丸くん[/color]: [/b]",
		"[b][color=#F0FFF0]卵焼きさん[/color]: [/b]",
		"[b][color=#E6E6FA]ケロケロ[/color]: [/b]",
		"[b][color=#EE82EE]白玉くん[/color]: [/b]",
		"[b][color=#32CD32]由さん[/color]: [/b]",
	]
	var hentais = [
		"[b][color=#DC143C]FatMan[/color]: [/b]",
		"[b][color=#8B0000]tadanodoutei[/color]: [/b]",
		"[b][color=#FFC0CB]マリオじゃないパイプマスッター[/color]: [/b]",
		"[b][color=#FFFF00]本物のくそ童貞4545[/color]: [/b]",
		"[b][color=#FFD700]おかま嫌いくん[/color]: [/b]",
		"[b][color=#006400]アナルの内側[/color]: [/b]",
		"[b][color=#FFEBCD]HARAMASE_MASHIN[/color]: [/b]",
		"[b][color=#F5F5DC]熱くって臭くってドロドロの[/color]: [/b]",
		"[b][color=#FFF8DC]SeiekiNondene[/color]: [/b]",
		"[b][color=#7FFF00]尻舐め69[/color]: [/b]",
		"[b][color=#6495ED]oppai_daisuki3[/color]: [/b]",
		"[b][color=#800000]ジャックザレイプ[/color]: [/b]",
		"[b][color=#C71585]非童貞さま69[/color]: [/b]",
		"[b][color=#FFDEAD]君のお母さんを○○○[/color]: [/b]",
		"[b][color=#FFA500]おばさんフェッチ[/color]: [/b]",
		"[b][color=#4169E1]POTUSU_KUNKUN69[/color]: [/b]",
		"[b][color=#DB7093]パンツ人間[/color]: [/b]",
		"[b][color=#808000]13センチおちんちんさん[/color]: [/b]",
		"[b][color=#DAA520]めちゃでかいおちんちんさま[/color]: [/b]",
		"[b][color=#7CFC00]kimino_otousan69[/color]: [/b]",
		"[b][color=#FFB6C1]magyakunoranasan[/color]: [/b]",
		"[b][color=#FFA07A]欠穴レイダー[/color]: [/b]",
		"[b][color=#FFEFD5]非日本人嫌い[/color]: [/b]",
		"[b][color=#2E8B57]ヒトラーは正しい[/color]: [/b]",
		"[b][color=#FF6347]ロリコンマスタ[/color]: [/b]",
		"[b][color=#008000]パレスチナ人の金玉[/color]: [/b]",
		"[b][color=#D2B48C]ビッチ狩り420[/color]: [/b]",
		"[b][color=#008080]まんこ潰し[/color]: [/b]",
		"[b][color=#D8BFD8]まんこ舐め舐め６９００[/color]: [/b]",
		"[b][color=#F5DEB3]すっぽんぽんおじたん[/color]: [/b]",
		"[b][color=#00FF7F]ちんこが暑すぎるん[/color]: [/b]",
		"[b][color=#FF69B4]洗脳ペドさん[/color]: [/b]",
		"[b][color=#ADFF2F]okamatin[/color]: [/b]",
		"[b][color=#F0FFF0]norotin[/color]: [/b]",
		"[b][color=#E6E6FA]早漏マスター[/color]: [/b]",
		"[b][color=#EE82EE]ディルド人間[/color]: [/b]",
		"[b][color=#32CD32]Hゴブリン[/color]: [/b]",
		"[b][color=#00FA9A]ちんぽ小モン[/color]: [/b]",
		"[b][color=#FFE4B5]TんTん[/color]: [/b]",
		"[b][color=#AFEEEE]doutei_43sai[/color]: [/b]",
		"[b][color=#FF00FF]セックスマシン[/color]: [/b]",
		"[b][color=#CD853F]寝取られた人[/color]: [/b]",
		"[b][color=#4B0082]ビッチ殺し[/color]: [/b]",
		"[b][color=#00BFFF]終わらない4545[/color]: [/b]",
		"[b][color=#1E90FF]４５人減[/color]: [/b]",
		"[b][color=#A52A2A]うんち食べたい4545[/color]: [/b]",
	]
	
	var perv = "".join(perverts)
	var gatien = "".join(gatikois_en)
	var hent = "".join(hentais)
	var gatijp = "".join(gatikois_jp)
	
	var pool = $"..".Chatters
	var rng = RandomNumberGenerator.new()
	
	if group == "perverts":
		while true:
			var random = pool[rng.randi_range(0,pool.size())]
			if perv.contains(random):
				return random
	if group == "gatikois_en":
		while true:
			var random = pool[rng.randi_range(0,pool.size())]
			if gatien.contains(random):
				return random
	if group == "gatikois_jp":
		while true:
			var random = pool[rng.randi_range(0,pool.size())]
			if gatijp.contains(random):
				return random
	if group == "hentais":
		while true:
			var random = pool[rng.randi_range(0,pool.size())]
			if hent.contains(random):
				return random
