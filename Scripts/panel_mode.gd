extends Node2D

@export var AutoChat : bool = true

signal relay_chat(message : String)

var nodes
var currentGroup = "live_element"
@onready var glob = get_node("/root/globals")
@onready var ItemBoxMaxSize = 16

@onready var stamps = {
	"ahegao_1" : "[img=128x128]res://Sprites/Stamps/ahegao_1.png[/img]",
	"ahegao_2" : "[img=128x128]res://Sprites/Stamps/ahegao_2.png[/img]",
	"ahegao_3" : "[img=128x128]res://Sprites/Stamps/ahegao_3.png[/img]",
	"ahegao_4" : "[img=128x128]res://Sprites/Stamps/ahegao_4.png[/img]",
	"ahegao_5" : "[img=128x128]res://Sprites/Stamps/ahegao_5.png[/img]",
	"ahegao_6" : "[img=128x128]res://Sprites/Stamps/ahegao_6.png[/img]",
	"angry_1" : "[img=128x128]res://Sprites/Stamps/angry_1.png[/img]",
	"angry_2" : "[img=128x128]res://Sprites/Stamps/angry_2.png[/img]",
	"angry_3" : "[img=128x128]res://Sprites/Stamps/angry_3.png[/img]",
	"ass_1" : "[img=128x128]res://Sprites/Stamps/ass_1.png[/img]",
	"ass_2" : "[img=128x128]res://Sprites/Stamps/ass_2.png[/img]",
	"boobs_1" : "[img=128x128]res://Sprites/Stamps/boobs_1.png[/img]",
	"boobs_2" : "[img=128x128]res://Sprites/Stamps/boobs_2.png[/img]",
	"bukkake_1" : "[img=128x128]res://Sprites/Stamps/bukkake_1.png[/img]",
	"butt_1" : "[img=128x128]res://Sprites/Stamps/butt_1.png[/img]",
	"cute_1" : "[img=128x128]res://Sprites/Stamps/cute_1.png[/img]",
	"cute_2" : "[img=128x128]res://Sprites/Stamps/cute_2.png[/img]",
	"cute_3" : "[img=128x128]res://Sprites/Stamps/cute_3.png[/img]",
	"cute_blush_1" : "[img=128x128]res://Sprites/Stamps/cute_blush_1.png[/img]",
	"disgust_1" : "[img=128x128]res://Sprites/Stamps/disgust_1.png[/img]",
	"eating_1" : "[img=128x128]res://Sprites/Stamps/eating_1.png[/img]",
	"embarrassed_1" : "[img=128x128]res://Sprites/Stamps/embarrassed_1.png[/img]",
	"embarrassed_2" : "[img=128x128]res://Sprites/Stamps/embarrassed_2.png[/img]",
	"feet_1" : "[img=128x128]res://Sprites/Stamps/feet_1.png[/img]",
	"feet_2" : "[img=128x128]res://Sprites/Stamps/feet_2.png[/img]",
	"gloomy_stare_1" : "[img=128x128]res://Sprites/Stamps/gloomy_stare_1.png[/img]",
	"lmao_1" : "[img=128x128]res://Sprites/Stamps/lmao_1.png[/img]",
	"panic_1" : "[img=128x128]res://Sprites/Stamps/panic_1.png[/img]",
	"panic_2" : "[img=128x128]res://Sprites/Stamps/panic_2.png[/img]",
	"pregnant_1" : "[img=128x128]res://Sprites/Stamps/pregnant_1.png[/img]",
	"pout_1" : "[img=128x128]res://Sprites/Stamps/pout_1.png[/img]",
	"scary_1" : "[img=128x128]res://Sprites/Stamps/scary_1.png[/img]",
	"sleeping_1" : "[img=128x128]res://Sprites/Stamps/sleeping_1.png[/img]",
	"smile_1" : "[img=128x128]res://Sprites/Stamps/smile_1.png[/img]",
	"smile_3" : "[img=128x128]res://Sprites/Stamps/smile_3.png[/img]",
	"smug_3" : "[img=128x128]res://Sprites/Stamps/smug_3.png[/img]",
	"wasted_1" : "[img=128x128]res://Sprites/Stamps/wasted_1.png[/img]",
	"wasted_2" : "[img=128x128]res://Sprites/Stamps/wasted_2.png[/img]",
}

var sexual_harasment_ = []
var sekuhara_ = []
var gatikoi_en_ = []
var gatikoi_jp_ = []

var Chatters = {
		#special chars
		"ファットアッス" = "[b][color=#DC143C]ファットアッス[/color]: [/b]",
		"デカジリデブオくん" = "[b][color=#8B0000]デカジリデブオくん[/color]",
		"可愛いくないフォックス" = "[b][color=#FFC0CB]可愛いくないフォックス[/color]: [/b]",
		"ロり汁ください" = "[b][color=#FFFF00]ロり汁ください[/color]: [/b]",
		"熊パンキング" = "[b][color=#FFD700]熊パンキング[/color]: [/b]",
		"4545の達人" = "[b][color=#006400]4545の達人[/color]: [/b]",
		"JohnHicc" = "[b][color=#DC143C]JohnHicc[/color]: [/b]",
		"ReinBohr" = "[b][color=#F5F5DC]ReinBohr[/color]: [/b]",
		"riritan_enjoyer101" = "[b][color=#FFF8DC]riritan_enjoyer101[/color]: [/b]",
		"Kodyn88" = "[b][color=#7CFC00]Kodyn88[/color]: [/b]",
		"LoliLover690" = "[b][color=#F5DEB3]LoliLover690[/color]: [/b]",
		"MrSlimeyWackey" = "[b][color=#E6E6FA]MrSlimeyWackey[/color]: [/b]",
		"doutei_43sai" = "[b][color=#AFEEEE]doutei_43sai[/color]: [/b]",
		"GeorgeFloyder_BLM" = "[b][color=#A85E15]GeorgeFloyder_BLM[/color]: [/b]",
		#hentais en
		"SexatronMax" = "[b][color=#DC143C]SexatronMax[/color]: [/b]",
		"KingOfSEXO" = "[b][color=#8B0000]KingOfSEXO[/color]: [/b]",
		"wooden_horsie" = "[b][color=#FFC0CB]wooden_horsie[/color]: [/b]",
		"LiteralFucker" = "[b][color=#FFFF00]LiteralFucker[/color]: [/b]",
		"iHateGays" = "[b][color=#FFD700]iHateGays[/color]: [/b]",
		"inside__asshole" = "[b][color=#006400]inside__asshole[/color]: [/b]",
		"AverageCoomer" = "[b][color=#FFEBCD]AverageCoomer[/color]: [/b]",
		"hotStinkyCoom" = "[b][color=#F5F5DC]hotStinkyCoom[/color]: [/b]",
		"plsdrinkmahcoom" = "[b][color=#FFF8DC]plsdrinkmahcoom[/color]: [/b]",
		"BootaLickah69" = "[b][color=#7FFF00]BootaLickah69[/color]: [/b]",
		"booba_enjoyer69" = "[b][color=#6495ED]booba_enjoyer69[/color]: [/b]",
		"JackTheRaper" = "[b][color=#800000]JackTheRaper[/color]: [/b]",
		"SEXOmaster" = "[b][color=#C71585]SEXOmaster[/color]: [/b]",
		"iAteUrMum" = "[b][color=#FFDEAD]iAteUrMum[/color]: [/b]",
		"milf_enjoyer" = "[b][color=#FFA500]milf_enjoyer[/color]: [/b]",
		"Joe_Sniffer" = "[b][color=#4169E1]Joe_Sniffer[/color]: [/b]",
		"YourMomsUnderwear" = "[b][color=#DB7093]YourMomsUnderwear[/color]: [/b]",
		"23cmPeenOwner" = "[b][color=#808000]23cmPeenOwner[/color]: [/b]",
		"MaximusSchlonger" = "[b][color=#DAA520]MaximusSchlonger[/color]: [/b]",
		"your_daddy69" = "[b][color=#7CFC00]your_daddy69[/color]: [/b]",
		"LanaButBackwards" = "[b][color=#FFB6C1]LanaButBackwards[/color]: [/b]",
		"RectumInvader69" = "[b][color=#FFA07A]RectumInvader69[/color]: [/b]",
		"KILL_ALL_JEWS" = "[b][color=#FFEFD5]KILL_ALL_JEWS[/color]: [/b]",
		"hitler_was_right" = "[b][color=#2E8B57]hitler_was_right[/color]: [/b]",
		"Pedo4Life69" = "[b][color=#FF6347]Pedo4Life69[/color]: [/b]",
		"FreePalestine" = "[b][color=#008000]FreePalestine[/color]: [/b]",
		"skankhunt45" = "[b][color=#D2B48C]skankhunt45[/color]: [/b]",
		"pussycrusher6900" = "[b][color=#008080]pussycrusher6900[/color]: [/b]",
		"iLickPussies6969" = "[b][color=#D8BFD8]iLickPussies6969[/color]: [/b]",
		"ihavenopantsonttv" = "[b][color=#F5DEB3]ihavenopantsonttv[/color]: [/b]",
		"JunkIsHot" = "[b][color=#00FF7F]JunkIsHot[/color]: [/b]",
		"groom_zah_children" = "[b][color=#FF69B4]groom_zah_children[/color]: [/b]",
		"DragPeen4Kids" = "[b][color=#ADFF2F]DragPeen4Kids[/color]: [/b]",
		"slow_coomer" = "[b][color=#F0FFF0]slow_coomer[/color]: [/b]",
		"premature_coomer" = "[b][color=#E6E6FA]premature_coomer[/color]: [/b]",
		"Dildoman" = "[b][color=#EE82EE]Dildoman[/color]: [/b]",
		"hornygoblin" = "[b][color=#32CD32]hornygoblin[/color]: [/b]",
		"MidgetPenis" = "[b][color=#00FA9A]MidgetPenis[/color]: [/b]",
		"ProCocker55" = "[b][color=#FFE4B5]ProCocker55[/color]: [/b]",
		"42yo_virgin" = "[b][color=#AFEEEE]42yo_virgin[/color]: [/b]",
		"SexMachine88" = "[b][color=#FF00FF]SexMachine88[/color]: [/b]",
		"TheCuckHimself" = "[b][color=#CD853F]TheCuckHimself[/color]: [/b]",
		"bitch_killer690" = "[b][color=#4B0082]bitch_killer690[/color]: [/b]",
		"EpsteinsClient" = "[b][color=#00BFFF]EpsteinsClient[/color]: [/b]",
		"PedoPete" = "[b][color=#1E90FF]PedoPete[/color]: [/b]",
		"dungeater" = "[b][color=#A52A2A]dungeater[/color]: [/b]",
		"N07_N1663R" = "[b][color=#A52A2A]N07_N1663R[/color]: [/b]",
		
		#gatikois en
		
		"Vote4TrumpMAGA" = "[b][color=#8B0000]Vote4TrumpMAGA[/color]: [/b]",
		"KingOfSimps77" = "[b][color=#FFC0CB]KingOfSimps77[/color]: [/b]",
		"only_natsuki" = "[b][color=#FFFF00]only_natsuki[/color]: [/b]",
		"crispy_sausage89" = "[b][color=#FFD700]crispy_sausage89[/color]: [/b]",
		"AtomicThumb98" = "[b][color=#006400]AtomicThumb98[/color]: [/b]",
		"moolampy" = "[b][color=#FFEBCD]moolampy[/color]: [/b]",
		"OnlyRiritan" = "[b][color=#7FFF00]OnlyRiritan[/color]: [/b]",
		"Ret_Ihweb" = "[b][color=#6495ED]Ret_Ihweb[/color]: [/b]",
		"IxyFox0" = "[b][color=#800000]IxyFox0[/color]: [/b]",
		"RedButtedMonkey" = "[b][color=#C71585]RedButtedMonkey[/color]: [/b]",
		"slothixus" = "[b][color=#FFDEAD]slothixus[/color]: [/b]",
		"professional_napper85" = "[b][color=#FFA500]professional_napper85[/color]: [/b]",
		"Mp5_SZ" = "[b][color=#4169E1]Mp5_SZ[/color]: [/b]",
		"ZaBigass" = "[b][color=#DB7093]ZaBigass[/color]: [/b]",
		"diaper_sandwich" = "[b][color=#808000]diaper_sandwich[/color]: [/b]",
		"CheapExpensiveVase" = "[b][color=#DAA520]CheapExpensiveVase[/color]: [/b]",
		"Ymen68" = "[b][color=#FFB6C1]Ymen68[/color]: [/b]",
		"SwearItWastMe" = "[b][color=#FFA07A]SwearItWastMe[/color]: [/b]",
		"shroom_soup" = "[b][color=#FFEFD5]shroom_soup[/color]: [/b]",
		"MellowApple" = "[b][color=#2E8B57]MellowApple[/color]: [/b]",
		"fluffy_doggo101" = "[b][color=#FF6347]fluffy_doggo101[/color]: [/b]",
		"CatPerson42" = "[b][color=#008000]CatPerson42[/color]: [/b]",
		"doggyturd4" = "[b][color=#D2B48C]doggyturd4[/color]: [/b]",
		"Turtle_Pie02" = "[b][color=#008080]Turtle_Pie02[/color]: [/b]",
		"sexy_robot00" = "[b][color=#D8BFD8]sexy_robot00[/color]: [/b]",
		"MassDeportationEnjoyer" = "[b][color=#00FF7F]MassDeportationEnjoyer[/color]: [/b]",
		"jc_kp442" = "[b][color=#FF69B4]jc_kp442[/color]: [/b]",
		"stinky_migrant" = "[b][color=#ADFF2F]stinky_migrant[/color]: [/b]",
		"mexican_otaku74" = "[b][color=#F0FFF0]mexican_otaku74[/color]: [/b]",
		"CommiesMustDie" = "[b][color=#EE82EE]CommiesMustDie[/color]: [/b]",
		"SuperDuperSomething" = "[b][color=#32CD32]SuperDuperSomething[/color]: [/b]",
		"chicken_deepfry" = "[b][color=#00FA9A]chicken_deepfry[/color]: [/b]",
		"cringeASF" = "[b][color=#FFE4B5]cringeASF[/color]: [/b]",
		"MahNeymi" = "[b][color=#AFEEEE]MahNeymi[/color]: [/b]",
		"miaumiau55" = "[b][color=#FF00FF]miaumiau55[/color]: [/b]",
		"Yenomon" = "[b][color=#CD853F]Yenomon[/color]: [/b]",
		
		#hentais jp
		"FatMan" = "[b][color=#DC143C]FatMan[/color]: [/b]",
		"tadanodoutei" = "[b][color=#8B0000]tadanodoutei[/color]: [/b]",
		"マリオじゃないパイプマスッター" = "[b][color=#FFC0CB]マリオじゃないパイプマスッター[/color]: [/b]",
		"本物のくそ童貞4545" = "[b][color=#FFFF00]本物のくそ童貞4545[/color]: [/b]",
		"おかま嫌いくん" = "[b][color=#FFD700]おかま嫌いくん[/color]: [/b]",
		"アナルの内側" = "[b][color=#006400]アナルの内側[/color]: [/b]",
		"HARAMASE_MASHIN" = "[b][color=#FFEBCD]HARAMASE_MASHIN[/color]: [/b]",
		"熱くって臭くってドロドロの" = "[b][color=#F5F5DC]熱くって臭くってドロドロの[/color]: [/b]",
		"SeiekiNondene" = "[b][color=#FFF8DC]SeiekiNondene[/color]: [/b]",
		"尻舐め69" = "[b][color=#7FFF00]尻舐め69[/color]: [/b]",
		"oppai_daisuki3" = "[b][color=#6495ED]oppai_daisuki3[/color]: [/b]",
		"ジャックザレイプ" = "[b][color=#800000]ジャックザレイプ[/color]: [/b]",
		"非童貞さま69" = "[b][color=#C71585]非童貞さま69[/color]: [/b]",
		"君のお母さんを○○○" = "[b][color=#FFDEAD]君のお母さんを○○○[/color]: [/b]",
		"おばさんフェッチ" = "[b][color=#FFA500]おばさんフェッチ[/color]: [/b]",
		"POTUSU_KUNKUN69" = "[b][color=#4169E1]POTUSU_KUNKUN69[/color]: [/b]",
		"パンツ人間" = "[b][color=#DB7093]パンツ人間[/color]: [/b]",
		"13センチおちんちんさん" = "[b][color=#808000]13センチおちんちんさん[/color]: [/b]",
		"めちゃでかいおちんちんさま" = "[b][color=#DAA520]めちゃでかいおちんちんさま[/color]: [/b]",
		"kimino_otousan69" = "[b][color=#7CFC00]kimino_otousan69[/color]: [/b]",
		"magyakunoranasan" = "[b][color=#FFB6C1]magyakunoranasan[/color]: [/b]",
		"欠穴レイダー" = "[b][color=#FFA07A]欠穴レイダー[/color]: [/b]",
		"非日本人嫌い" = "[b][color=#FFEFD5]非日本人嫌い[/color]: [/b]",
		"ヒトラーは正しい" = "[b][color=#2E8B57]ヒトラーは正しい[/color]: [/b]",
		"ロリコンマスタ" = "[b][color=#FF6347]ロリコンマスタ[/color]: [/b]",
		"パレスチナ人の金玉" = "[b][color=#008000]パレスチナ人の金玉[/color]: [/b]",
		"ビッチ狩り420" = "[b][color=#D2B48C]ビッチ狩り420[/color]: [/b]",
		"まんこ潰し" = "[b][color=#008080]まんこ潰し[/color]: [/b]",
		"まんこ舐め舐め６９００" = "[b][color=#D8BFD8]まんこ舐め舐め６９００[/color]: [/b]",
		"すっぽんぽんおじたん" = "[b][color=#F5DEB3]すっぽんぽんおじたん[/color]: [/b]",
		"ちんこが暑すぎるん" = "[b][color=#00FF7F]ちんこが暑すぎるん[/color]: [/b]",
		"洗脳ペドさん" = "[b][color=#FF69B4]洗脳ペドさん[/color]: [/b]",
		"okamatin" = "[b][color=#ADFF2F]okamatin[/color]: [/b]",
		"norotin" = "[b][color=#F0FFF0]norotin[/color]: [/b]",
		"早漏マスター" = "[b][color=#E6E6FA]早漏マスター[/color]: [/b]",
		"ディルド人間" = "[b][color=#EE82EE]ディルド人間[/color]: [/b]",
		"Hゴブリン" = "[b][color=#32CD32]Hゴブリン[/color]: [/b]",
		"ちんぽ小モン" = "[b][color=#00FA9A]ちんぽ小モン[/color]: [/b]",
		"TんTん" = "[b][color=#FFE4B5]TんTん[/color]: [/b]",
		"セックスマシン" = "[b][color=#FF00FF]セックスマシン[/color]: [/b]",
		"寝取られた人" = "[b][color=#CD853F]寝取られた人[/color]: [/b]",
		"ビッチ殺し" = "[b][color=#4B0082]ビッチ殺し[/color]: [/b]",
		"終わらない4545" = "[b][color=#00BFFF]終わらない4545[/color]: [/b]",
		"４５人減" = "[b][color=#1E90FF]４５人減[/color]: [/b]",
		"うんち食べたい4545" = "[b][color=#A52A2A]うんち食べたい4545[/color]: [/b]",
		
		#gatikois jp
		"ネットおじたん" = "[b][color=#DC143C]ネットおじたん[/color]: [/b]",
		"ア君" = "[b][color=#8B0000]ア君[/color]: [/b]",
		"せいちゃん" = "[b][color=#FFC0CB]せいちゃん[/color]: [/b]",
		"Tanuki" = "[b][color=#FFFF00]Tanuki[/color]: [/b]",
		"IkaYakiMaster" = "[b][color=#FFD700]IkaYakiMaster[/color]: [/b]",
		"NekoNyanNko" = "[b][color=#006400]NekoNyanNko[/color]: [/b]",
		"OnigiriShokunin" = "[b][color=#FFEBCD]OnigiriShokunin[/color]: [/b]",
		"NegitamaDon" = "[b][color=#F5F5DC]NegitamaDon[/color]: [/b]",
		"おでんやのおやじ" = "[b][color=#FFF8DC]おでんやのおやじ[/color]: [/b]",
		"TakoyakiMania" = "[b][color=#7FFF00]TakoyakiMania[/color]: [/b]",
		"しろくまカレー" = "[b][color=#6495ED]しろくまカレー[/color]: [/b]",
		"ChikuwaBunko" = "[b][color=#800000]ChikuwaBunko[/color]: [/b]",
		"Mikan-gumi" = "[b][color=#C71585]Mikan-gumi[/color]: [/b]",
		"Nekofunjya" = "[b][color=#FFDEAD]Nekofunjya[/color]: [/b]",
		"猫になってみたい人さん" = "[b][color=#FFA500]猫になってみたい人さん[/color]: [/b]",
		"イチゴジャムおじ" = "[b][color=#4169E1]イチゴジャムおじ[/color]: [/b]",
		"おばあちゃんのとうもろこし" = "[b][color=#DB7093]おばあちゃんのとうもろこし[/color]: [/b]",
		"天竜座の人" = "[b][color=#808000]天竜座の人[/color]: [/b]",
		"夢に出てくるカエルさん" = "[b][color=#DAA520]夢に出てくるカエルさん[/color]: [/b]",
		"お化けカボチャ" = "[b][color=#7CFC00]お化けカボチャ[/color]: [/b]",
		"一人ぼっちの熊さん" = "[b][color=#FFB6C1]一人ぼっちの熊さん[/color]: [/b]",
		"ちいさなてんとう虫さん" = "[b][color=#FFA07A]ちいさなてんとう虫さん[/color]: [/b]",
		"いちごショートケーキ" = "[b][color=#FFEFD5]いちごショートケーキ[/color]: [/b]",
		"おばあちゃんの大根" = "[b][color=#2E8B57]おばあちゃんの大根[/color]: [/b]",
		"一つの卵さん" = "[b][color=#FF6347]一つの卵さん[/color]: [/b]",
		"苺おじさん" = "[b][color=#008000]苺おじさん[/color]: [/b]",
		"黒猫のおやつ" = "[b][color=#D2B48C]黒猫のおやつ[/color]: [/b]",
		"ジャガメロンさん" = "[b][color=#008080]ジャガメロンさん[/color]: [/b]",
		"ゆめみるく" = "[b][color=#D8BFD8]ゆめみるく[/color]: [/b]",
		"ひらがなもじっこさん" = "[b][color=#F5DEB3]ひらがなもじっこさん[/color]: [/b]",
		"水早江さん" = "[b][color=#00FF7F]水早江さん[/color]: [/b]",
		"青い鳥さん" = "[b][color=#FF69B4]青い鳥さん[/color]: [/b]",
		"猫丸くん" = "[b][color=#ADFF2F]猫丸くん[/color]: [/b]",
		"卵焼きさん" = "[b][color=#F0FFF0]卵焼きさん[/color]: [/b]",
		"ケロケロ" = "[b][color=#E6E6FA]ケロケロ[/color]: [/b]",
		"白玉くん" = "[b][color=#EE82EE]白玉くん[/color]: [/b]",
		"由さん" = "[b][color=#32CD32]由さん[/color]: [/b]",
		}
		

# Called when the node enters the scene tree for the first time.
func _ready():
	update_elements()
	for i in range(11): 
		push_chat()
		$ChatControl/Chat/s1/RichTextLabel.text = filler_message_generator()
	#$ChatControl/Chat/s1/RichTextLabel.set_text("[b][color=BlueViolet]SexatronMax[/color]: [/b][img=48x48]res://Sprites/Misc/chibi_yukachan.png[/img]")
	if "ItemBox" not in glob.Save:
		glob.Save["ItemBox"] = []
	

func _process(delta):
	
	if glob.Save["FirstTimeUsingPanelMode"] && glob.isPanelMode:
		$Scenarios.live_scenario("panel_tutorial_1")
		glob.Save["FirstTimeUsingPanelMode"] = false
	
	$Money.text = str(glob.Save["Money"])
	
	if Input.is_action_just_pressed("ui_accept") && glob.isPanelMode:
		pass
		
	if Input.is_action_just_pressed("ui_test") && glob.isPanelMode:
		for i in range(20):
			$ScrollContainer/ShopItemsListing.add_child($ScrollContainer/ShopItemsListing/ShopItemMargin.duplicate())

	if Input.is_action_just_pressed("ui_cancel") && glob.isPanelMode:
		glob.holdImage = glob.printScreen()
		
		
	if glob.Save["TempFlag"] != null:
		var flag = glob.Save["TempFlag"]
		
		if flag == "highlight_requests":
			$RedArrow.visible = true
			glob.Save["TempFlag"] = "wait_for_player_to_click_requests_and_play_tutorial"
			
	glob.update_expression($Control/SubViewportContainer/SubViewport/CharSprite)
	

func type(text):
	if text == "sekuhara":
		return
	if text == "gatikoi":
		return
	if text == "anti":
		return
	if text == "random":
		return
		
	push_chat()
	$ChatControl/Chat/s1/RichTextLabel.set_text(text)
	
func _on_live_pressed():
	if ($Control/SubViewportContainer/SubViewport/Textbox.visible || $Textbox.visible) || (glob.Save["TempFlag"] != "wait_for_player_to_click_requests_and_play_tutorial" && glob.Save["FirstTimeUsingPanelMode"]):
		return
	currentGroup = "live_element"
	update_elements()

func _on_requests_pressed():
	if ($Control/SubViewportContainer/SubViewport/Textbox.visible || $Textbox.visible) || (glob.Save["TempFlag"] != "wait_for_player_to_click_requests_and_play_tutorial" && glob.Save["FirstTimeUsingPanelMode"]):
		return
	
	currentGroup = "requests_element"
	update_elements()
	if glob.Save["TempFlag"] == "wait_for_player_to_click_requests_and_play_tutorial":
		$RedArrow.visible = false
		$Scenarios.live_scenario("panel_tutorial_2")
		glob.Save["TempFlag"] = null

func _on_shop_pressed():
	if ($Control/SubViewportContainer/SubViewport/Textbox.visible || $Textbox.visible) || (glob.Save["TempFlag"] != "wait_for_player_to_click_requests_and_play_tutorial" && glob.Save["FirstTimeUsingPanelMode"]):
		return
	
	currentGroup = "shop_element"
	update_elements()

func update_elements():
	nodes = self.get_children()
	for n in nodes:
		if n.is_in_group(currentGroup):
			print(n.name + " is now visible")
			n.visible = true
		if !n.is_in_group(currentGroup)  && "visible" in n:
			print(n.name + " is now invisible")
			n.visible = false
		if n.is_in_group("always_visible") && "visible" in n:
			n.visible = true

func push_chat():
	var arr = ["","","","","","","","","",""]
	arr[0] = $ChatControl/Chat/s1/RichTextLabel.text
	arr[1] = $ChatControl/Chat/s2/RichTextLabel.text
	arr[2] = $ChatControl/Chat/s3/RichTextLabel.text
	arr[3] = $ChatControl/Chat/s4/RichTextLabel.text
	arr[4] = $ChatControl/Chat/s5/RichTextLabel.text
	arr[5] = $ChatControl/Chat/s6/RichTextLabel.text
	arr[6] = $ChatControl/Chat/s7/RichTextLabel.text
	arr[7] = $ChatControl/Chat/s8/RichTextLabel.text
	arr[8] = $ChatControl/Chat/s9/RichTextLabel.text
	arr[9] = $ChatControl/Chat/s10/RichTextLabel.text
	$ChatControl/Chat/s2/RichTextLabel.text = arr.pop_front()
	$ChatControl/Chat/s3/RichTextLabel.text = arr.pop_front()
	$ChatControl/Chat/s4/RichTextLabel.text = arr.pop_front()
	$ChatControl/Chat/s5/RichTextLabel.text = arr.pop_front()
	$ChatControl/Chat/s6/RichTextLabel.text = arr.pop_front()
	$ChatControl/Chat/s7/RichTextLabel.text = arr.pop_front()
	$ChatControl/Chat/s8/RichTextLabel.text = arr.pop_front()
	$ChatControl/Chat/s9/RichTextLabel.text = arr.pop_front()
	$ChatControl/Chat/s10/RichTextLabel.text = arr.pop_front()
	$ChatControl/Chat/s1/RichTextLabel.text = ""

func chat(speaker : String, message : String):
	push_chat()
	$ChatControl/Chat/s1/RichTextLabel.text = Chatters[speaker] + glob.TranslationWrapper(message)
	relay_chat.emit(Chatters[speaker] + glob.TranslationWrapper(message))

func filler_message_generator(group : String = "random"):
	var perverts = [
		"[b][color=#A85E15]GeorgeFloyder_BLM[/color]: [/b]",
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
	
	var normies = [
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
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
	
	var sexual_harasment = [
		"You should be a porn star because your body is perfect for it! I wish I could fuck you in every way possible!",
		"Your boobs are amazing! They look like they were made just for you to suck on them all day!",
		"I bet your pussy tastes so good! I wish I could eat it out!",
		"You should wear shorter clothes so people can see what a sexy body you have!",
		"I love your face! You look so cute when you're sad!",
		"You're so hot, I'd fuck you right now if I could!",
		"I love your tits! They look so good in that shirt!",
		"show feet pls",
		"I beg, show your feet!",
		"Can we see some feet pls?",
		"if i give u 5 bucks can u show ur feet?",
		"when i think about your feet my schlong ascends to heaven, pls show feet!",
		"the moment i see your feet i will cum like never before!",
		"i wanna lick your feet so bad im gonna die",
		"Bet your toes are as lewd as your tits, can you show them feets please? \n"+stamps["feet_1"],
		"step on me",
		"The smell of your underwear isn't enough, if u get out of there sell me the smell of your feet please.",
		"I would lick your feet clean right now",
		"U got kidnapped in your sleep right? So... Are u barefoot rn? The fact you have no shoes makes me so hard, god, gonna coom!",
		"My dick is down bad, please show feet to make it up good hahahahaha im so funny \n"+stamps["lmao_1"],
		"i wanna cum on your feet so baaaaad",
		"SEX FAP CUM FEET 69 I DO U GOOOOOOD!!!",
		"wanna suck your toes so bad",
		"ngl i wanna lick your toes really bad",
		"i can't wait to release big loads on ur feet",
		"wanna make love to your toes",
		"show booba pls "+stamps["boobs_1"],
		"wanna have intercourse with your feet so bad",
		"wanna suck your toes real good",
		"I WANT YOUR TOES INSIDE MY ASSHOLE",
		"I WANT YOUR TOES INSIDE MY MOUTH",
		"would love getting my nipples pinched by your toes",
		"your boobs look so nice, not being topless is blasphemy!",
		"take your shirt off, please, I beg of you ",
		"what are your 3 sizes?",
		"what cup are your tits?",
		"can you please show your nipples?",
		"how many men did u milk with these succulent breasts of yours?",
		"i wanna rub my veiny hard cock on your nipples",
		"I would fuck your tits with as much passion as Joe sniffs kids",
		"If u become my bitch I promise to massage your booba every day!",
		"SHOW YOUR BOOBS RIGHT NOW OR I'LL MURDER YOUR WHOLE FAMILY!!!",
		"I wanna see you on all fours with those big titties hanging real nice.",
		"show boobs please "+stamps["boobs_2"],
		"please take your boobs out",
		"Your boobs look like milk would come out of them if I squeezed them, dang!",
		"nice tits bitch",
		"no wonder you got kidnapped in your sleep when you go to sleep dressed like a stripper like that",
		"your sleepwear look like that of a stripper, love it, but you would look better without it",
		"There are no clothes worth of you, please stop using them.",
		"wanna see you use toilet",
		"i would attack your pussy like kkk would attack a nigger",
		"I'm a seer, I know you have no panties on, you have a jewel box on!",
		"wanna see your butthole so bad...",
		"i would eat your poop",
		"I would drink your piss",
		"try finger but whole",
		"69",
		"Love seeing arrogant little bitches being put in their due place!",
		"coom "+stamps["wasted_2"],
		"asshole > pussy",
		"feet > boobs",
		"Take off your clothes, please. I want to see you in all your glory.",
		"Why are you covering up those gorgeous tits? You're just teasing us!",
		"I bet those tits taste amazing. Can we get a taste, please?",
		"Please take off your bra and show us what you got under there.",
		"Can we see how big those nipples are? I have a feeling they're huge.",
		"Please remove those pants and give us a look at that juicy ass of yours.",
		"Why are you hiding that beautiful body of yours? Show it to us, please.",
		"I want to see you get naked and dance for us. Can we have a little striptease, please?",
		"Please bend over and give us a nice view of that ass. I want to see those curves in all their glory.",
		"Can we see your butthole? I'm curious to know what it looks like.",
		"I would lick every inch of your body, from your toes to your tits.",
		"Being kidnapped is all your fault for tempting men like that you nasty nasty girl",
		"Can we get a closer look at those pretty little ankles of yours? They're so sexy and cute.",
		"I have a feeling you have some really nice calves. Can we see them, please?",
		"I want to see you do some squats or lunges in your underwear",
		"Can we get a look at those big tits of yours from the side? I have a feeling they're even more amazing from that angle.",
		"Why are you covering up those gorgeous nipples with those clothes? Let us see them, please!",
		"Please take off your shirt and show us those beautiful breasts of yours.",
		"Please bend over and give us a nice view of those gorgeous tits. I want to see them from every angle!",
		"Can we get a closer look at those pretty little freckles on your chest? They're so cute!",
		"You would make for such a perfect victim in my sex trafficking scheme",
		"I would like to see your naked body being used as a human punching bag",
		"me piss on your pussy?",
		"I bet you would love being used as a sex doll for a bunch of horny men",
		"Show us your feet AND your asshole pls",
		"You would make for such an excellent slut to be shared amongst a group of men",
		"Suck my big black dick while I urinate on you",
		"I wish I could see the look on your face when I cum all over your tits",
		"I bet you would love having my tongue lick up and down your slit while you beg for more",
		"I hope your pussy gets ripped open by a giant dildo",
		"Your tits are so big, I could hide a watermelon in between them",
		"You would make for such an excellent fuck toy for me and my friends",
		"I bet you would love being tied up and gagged while we take turns fucking your tight little hole",
		"Wanna see what it's like to be used as a human dildo for a bunch of horny men?",
		"I wish I could see the look on your face when I cum all over your tits and then lick it off",
		"Suck my big black dick or watch me urinate all over you",
		"I hope your tits get ripped open by a giant pair of nipple clamps",
		"You're so hot, I bet you get lots of dick in that tight little pussy of yours.",
		"If you don't start showing me some feet action soon, I'm going to start sending pictures of my dick.",
		"I hope you choke on a big, fat cock when you wake up. That'll teach you to be a woman.",
		"If I had my way, I'd tie you up and make you cum until your pussy was raw and bleeding.",
		"You look so innocent and sweet, but I know for a fact that you're anything but. You're just a dirty little slut who loves getting fucked by big, nasty dicks.",
		"I hope you wake up with your hands cuffed to the bed and a huge, throbbing dick shoved deep inside your pussy. That way, you won't be able to do anything but take it like the dirty little slut you are.",
		"Show us ur fanny pls!"+stamps["feet_2"],
		"You need a good spanking to make those big tits bounce even better.",
		"I would make love to that tight little pussy of yours like a lion would make love to a gazelle.",
		"Can you show us what's between your legs? I'm dying to know!",
		"Can you show us between your toes?",
		"Show us your clit, it must be so pretty, like a little button of love.",
		"I wanna see those boobs bounce as you run.",
		"Can we see how big that ass of yours is? I'm dying to know.",
		"You look like a dirty little slut, and I love it. Keep those clothes on, baby.",
		"Your butt crack must be showing, please turn around for a sec! \n"+stamps["ass_1"],
		"Show us your underwear, must be so sexy and revealing!",
		"I would love to lick those feet of yours like a dog would lick its owner's feet.",
		"You're so hot I could fry an egg on your tits!",
		"Show us how you finger yourself with those long, slender fingers of yours!",
		"I hope your vagina is as wet and sticky as a snail's slime trail!",
		"If I had a chance to lick your pussy, I'd go down on you like a ravenous wolf!",
		"You're such a tease, showing off those big tits and that curvy little body of yours but never giving us what we REALLY want!",
		"I hope you get fucked in the ass by a big black dick and have to swallow every last drop of cum!",
		"I love seeing little girls like you get fucked by older men",
		"I love it when little sluts like you get raped by big black dicks \n"+stamps["wasted_1"],
		"I want to lick your pussy until you cum",
		"You're nothing but a slutty little whore, now show us those tits and feet!",
		"Can we get a close up of your navel? It looks so delicious.",
		"Do you have any tattoos? I bet they're somewhere really dirty like your pussy or armpits.",
		"Are you lactating right now? I'd love to see some leaky titties.",
		"If I were kidnapped too, I'd want to be tied up and made to do all sorts of disgusting things by my captor. It sounds like so much fun!",
		"can't wait to show the video of me anally raping your mom \n"+stamps["scary_1"],
		"your boobs are nice but not big enough for my dick to fit!",
		"i wanna smell your underwear, its like a perfume made of your juices and piss stains",
		"show me where your period blood leaks from, ill use it as lube for my dick",
		"feet are for plebs, boobs are for kings, fight me!",
		"i wanna cum on your feet, then lick it up with my tongue while staring deep into your eyes",
		"you look like a slutty version of a cat, i hope your pussy is as tight as their ass",
		"show your pussy pls",
		"I'll lick your asshole and make you cum real hard",
		"Please show us your armpits!",
		"I want to lick your asshole while you're fingering yourself, sounds like fun, right?",
		"Your boobs must be really heavy, wanna show us how they hang down?",
		"I would blowjob your turd! Marry me PLEASE! I CAN DO RIMJOBS TOO! LET ME TASTE YOUR POO!",
		"Show them "+stamps["boobs_1"],
		"Wanna see some of these "+"\n"+stamps["boobs_1"],
		stamps["ahegao_1"],
		stamps["ahegao_2"],
		"We need "+stamps["ahegao_3"]+" stamps in youpipe as well! ",
		stamps["ahegao_4"],
		stamps["ahegao_5"],
		stamps["ahegao_6"],
		"When I get to you I'm making you like this \n"+stamps["wasted_1"],
		"If I were the one who kidnapped you, rn you'd be like \n"+stamps["wasted_2"],
		"Nice "+stamps["ass_1"]+" bitch!",
		"These chat stamps made me cum in my pants a little. \n"+stamps["boobs_2"],
		"My keyboard rn be like "+stamps["bukkake_1"],
		"Please pose like "+stamps["butt_1"]+" I'm really horny!",
		"Cute girl embarrassement is the fuel of the soul\n"+stamps["embarrassed_2"],
		"Once I'm president I'm making a mandate to all girls from 12yo to 28yo be topless all the time. Vote 4 me guys! \n"+stamps["embarrassed_1"],
		"It should be illegal for girls to hide their feet \n"+stamps["feet_1"],
		"Your body, MY choice. \n"+stamps["pregnant_1"],
		"Your body, my rules... \n"+stamps["pregnant_1"],
		"On a scale from 1 to 10 how strong do you like being slapped?\n"+stamps["ass_2"],
	]
	
	var sekuhara = [
		"足を見せてください",
		"お願いです、あなたの足を見せてください！",
		"少しでいいから足を見せてもらえませんか？",
		"500円あげるから、足を見せてくれないか？",
		"貴女の足を思うと私のちんこが天に昇りそうです。どうか、足を見せてください！",
		"貴女の足を一目見た瞬間には、今までにないほどイキ果てることでしょう！",
		"貴女の足が凄く欲しくてたまりません。",
		"僕は死ぬほどに君の足を舐めたいです",
		"僕を踏んでください！",
		"あなたのパンツの匂いだけじゃ足りません、出られたら、できれば足の匂いを売ってください",
		"今すぐ舐め清めてあげたいです、君の足を！",
		"寝ている間に誘拐されたんですよね？それで今は裸足なのかな？靴を履いてないってだけで、私のちんこがもう硬くなりそうなんです！",
		"ちんこが本当にダメになってしまた！足を見せてもらえれば元気になるぞーｗｗｗｗｗ！俺っておもろすぎるー！",
		"あなたの足にめちゃくちゃ射精したい",
		"性行為をして、フェラをして、そして私の足を舐めさせてあげます！やりまくっちゃいますよ！",
		"あなたの足指をしゃぶりてー",
		"貴女の足指をベロベロ舐めたいです！",
		"君の足指とセックスしたいんだが？",
		"胸を見せろや",
		"おっぱいできもちよくなりてえ",
		"俺のアナルに足指を突っ込んでください！",
		"乳首見せろよ！",
		"君の足とセックスしたくて堪らねえ！",
		"お前の指先を俺の口内に入れてくれえ！",
		"お前の足指で俺の乳首を挟んでください！！",
		"お前の胸はエロすぎるん、丸出しじゃないのは犯罪だぜー！",
		"淫乱め、いい乳もてるじゃねえか",
		"売女みたいな格好で就寝して、誘拐されて当然だな",
		"お前のパジャマはエロくって似合てるけど、全裸の方が似合と思うよ",
		"トイレ使てるところ見せろよ",
		"アナル見せろよ、もう我慢できねえ",
		"お前のウンコ食べたい",
		"お前の小便飲みたい",
		"指入れてみたい",
		"69しようぜ",
		"イクイクイクキウイクイクイクイクイクキウキウ",
		"欠穴よりマンコの方が良い！",
		"マンコより欠穴の方が良い！",
		"全裸ですごそうぜ、お前の全てを見たい",
		"おい、なんでそんなエロい体してんだよ？誘惑してんのか？",
		"その美味しそうな乳、味見させろや",
		"パンツを脱げ!",
		"このジューシーなケツを拝ませろや",
		"ストリップしろ!俺たちに見せつけろ!",
		"おい、ケツ突き出せや。あの曲線美を全部見せろ",
		"アナル見せてください。どんな感じなのか気になってたまらん！",
		"舐めたい！足指からおっぱいまで、全部だ！",
		"誘拐されたのはあんたが男を誘うようなふるまいしてたせいだぜ、全部君自身のせい！この阿婆擦れがよー",
		"下着姿でスクワットしろよ。そういうエロいところ見たいぜ",
		"セクシーでカワイイやつ",
		"お前の太もも、結構肉付き良いじゃん！見せてみろよ",
		"横から見たおっぱいも気になるんだよなー。絶対にエロいはずだ！",
		"このスケベな乳首を隠すなよ。見せろや！",
		"シャツ脱げって。お前の美乳見せろよ",
		"そのデカパイから全部見たいんだよ！",
		"お前は俺の性奴隷にピッタリだと思うわー",
		"大勢のチンポ狂いな男どもに人形みたいに使われるのが好きそうなー",
		"足とケツを見せろよ。頼むから",
		"大勢の男たちに共有されって最高のスラットになれるぜー",
		"俺のデカ黒チンポしゃぶりながら小便かけられてみてー",
		"おっぱいでチンポコすりやがて懇願してくれる所みてー",
		"俺の舌をあんたのマンコで上下させながらもっとちょうだいって泣き叫べ！",
		"おまえのマンコはキツキツでか？巨大なパイブで引き裂いてやりたいわ",
		"お前は素晴らしいオモチャだね、友達と交代で犯すからさ、感謝しろよー！",
		"大勢の男たちに人形みたいにされてみないか？最高に気持ちいぜー",
		"おっぱいでチンポコスりながら小便浴びせられる感触を味わいたいか？気持いいぜ",
		"ペロペロ",
		"デカ乳首クリップでおまえの乳首揉んでやりてえな",
		"そのキツいマンコにデカチンポぶち込みたくねえか？",
		"足見せろよ、見せないとチンポの写真送っちまうぞ",
		"手拘束したベッドにデカチンポ突っ込んでやるよ。そうすりゃただ取り合うしかねえ女だってことがわかるだろ",
		"お前可愛い顔してんのに、本当は汚くて下品なスラットなんだろ？デカチンポで犯されたか？",
		"あんたのマンコ見せてよ。どれだけ広くて深いのか知りたいんだ！",
		"ボディがエロすぎてマジでイっちゃったわ",
		"ケツ超セクシーだよね、アナルプラグ入れてやりたいくらい",
		"アナル見せろよ、マジで。俺はもう我慢できなくてさー",
		"触りたくてたまらないよ",
		"きみを見るだけで俺はギンギンになるよ",
		"デカバイブ入れたままでおまえのマンコ見てえなあ",
		"脱げ！",
		"パンツ見せろよ",
		"お尻の隙間見せてよ、見せろよ！",
		"君の足を犬みたいに舐めまわしたい！",
		"ちんこで卵を焼けるくらい熱いよぉぉぉぉ",
		"自分で自分を慰めるところ見せてよ、長い指で自分を掻き回してさー！",
		"マンコを舐められたら、飢えた狼みたいに貪りつくよ！",
		"あんたって本当に生意気な女だよね、大きなおっぱいとセクシーな体を見せびらかしておいて何もくれないなんてさー！",
		"黒人チンポでアナル犯されるところ見たい！",
		"俺は幼い女の子が黒人チンポでレイプされてるのを見るのが好きだ！",
		"マンコべろべろ舐め回してイカせたいんだ！",
		"今すぐにおっぱいと足見せろ！",
		"へえ、へそめちゃくちゃ美味しそうだなあ、近くで見たいよ",
		"お乳出せるの？",
		"いろんな汚いことされるのお楽しみですか？",
		"ママンをアナルレイプする",
		"ブス過ぎて笑えるけどおっぱいはいいね",
		"使用済みのナプキンでも送ってください。頼むから！",
		"マンコ見せてください",
		"あんたのウンコ吸い込んでフェラしてやる！結婚してくれPLEASE！",
	]
	
	var gatikoi_en = [
		"If I had a penny for every time you ignored me, I’d have enough to buy you a gift. Too bad I'm broke from spending all my money on your merch. Guess I’ll just continue living in my fantasy.",
		"I figured out why you haven't responded to my messages. You must be too busy being perfect to notice my pitiful attempts at communication. I'm just here, living in the shadows of your digital greatness.",
		"It's funny how I keep sending you messages and you never reply. I guess my love for you is like a black hole—no matter how much I give, it just keeps absorbing everything without a trace.",
		"I dream of the day when you'll notice me. Until then, I'll just continue to serenade you in the comments section like a delusional bard trapped in a digital dungeon.",
		"Just wanted to let you know that I’ve set up a shrine for you in my room. It’s mostly photos and candles. I’m pretty sure it’s the same thing as a love letter, but with more incense.",
		"You and I are like parallel lines—destined to never meet. But don't worry, I'm getting really good at drawing curves!",
		"I’ve been reading your horoscope daily. It always says, ‘Avoid obsessive stalkers.’ But don’t worry, I’m not obsessed. I just have a lot of free time!",
		"They say love is blind. Good thing, because I've been staring at your face for hours, and I think my eyes are bleeding.",
		"If I had a dollar for every time I thought about you, I'd buy a house next to yours... I mean, in the same city...",
		"I wrote a poem about you. It's called 'Ode to the Goddess I'll Never Have, But Who Stalks My Dreams.' It's more heartfelt than creepy, I promise!",
		"I named my new plant after you. It’s the only way I can watch you grow. And, uh, I promise not to overwater you this time.",
		"I wrote you a song! It’s called 'Why Won't You Acknowledge My Existence?' It's a little heavy...",
		"Hey, just wanted to let you know that I rearranged my room today. Now your face is the first thing I see when I wake up and the last thing I see before I sleep. It's almost like we're living together!",
		"Remember that time you posted about your love for coffee? I made you a cappuccino with the foam shaped like a restraining order.",
		"I bought you a dozen roses. Well, 11 now because one of them died, kind of like our non-existent relationship. But don't worry, I'll keep watering them with my tears",
		"I named my cat after you, and she ignores me just as well! \n"+stamps["smile_3"],
		"You know you're my soulmate when I've written more love letters to you than to my parole officer.",
		"I donated blood in your name today, just in case you ever need a transfusion. Talk about being there for someone!",
		"I've been sending you daily messages for a year, and the silence has been LOUD. Pretty sure the NSA thinks we're dating. 😂",
		"You’re like a shooting star. Brief, beautiful, and completely out of my reach.",
		"I know you said we’ll never be together, but I figured I’d stay optimistic. After all, even the Titanic had a few survivors.",
		"My therapist says I need to set more realistic goals. So now, instead of marrying you, I just aim to get a restraining order signed by you. #Goals",
		"If I had a dollar for every time I thought about you, I could probably buy enough therapy to get over you.",
		"I’ve decided to write a song about us. It’s called ‘Imaginary Girlfriend’. I’m sure it’ll be a hit in my head!",
		"Just wanted to let you know I named my Wi-Fi after you. Now, whenever my friends ask for the password, I just tell them they have no chance of getting in either. \n"+stamps["gloomy_stare_1"],
		"My phone battery loves you too. It dies every day just sending you messages!",
		"Even on your worst days, you’re still an incredible person. Keep your head up!",
		"You’re not alone in this. I’m here for you!",
		"Your strength and resilience inspire me every day. Don’t forget how amazing you are!",
		"Sending you a big virtual hug. You’re going to get through this!",
		"You have the kindest heart and the strongest spirit. Don’t let anything dim your light. \n"+stamps["smile_1"],
		"Your smile can light up a room. Don’t let anything steal that from you!",
		"You are loved more than you know. Hang in there!",
		"You are beautiful inside and out. Keep believing in yourself.",
		"It’s okay to ask for help. You don’t have to go through this alone.",
		"You’re stronger than you think, and you’re going to get through this.",
		"Don’t let today’s troubles steal tomorrow’s sunshine. You’ve got this!",
		"Your courage and determination are inspiring. Keep pushing forward.",
		"You’re an amazing person with so much to offer the world. Don’t let anything bring you down!",
		"You are a beautiful soul, and you deserve all the happiness in the world.",
		"Your smile can brighten even the darkest days. Keep smiling!",
		"You’ve faced so much already, and you’ve come so far. Keep going!",
		"You’re not alone in this journey. I’m here for you, always.",
		"You’re doing an amazing job, even when it doesn’t feel like it.",
		"You have the strength to overcome anything. Keep believing in yourself.",
		"You’re a fighter, and you’ve got this. Keep pushing forward!",
		"Your strength and resilience are inspiring. Don’t give up!",
		"You’ve got a heart full of love and a spirit full of strength. Keep going!",
		"You’ve got the strength to get through this. Keep believing in yourself!",
		"I believe in you. You've got this!",
		"You’ve made it through tough times before. You’ll get through this too.",
		"I'm so proud of you for holding on. Keep fighting.",
		"Your smile is like sunshine on a cloudy day.",
		"Sending positive vibes your way. You've got this!",
		"I’m here for you, always.",
		"Your positivity and strength are contagious.",
		"You have the power to overcome this. I believe in you.",
		"Your perseverance is admirable.",
		"You bring so much light to the world. Keep shining.",
		"Every challenge you overcome makes you stronger.",
		"You are an incredible person, and I'm here for you.",
		"Never forget how amazing you are. You've got this!",
		"Sorry I have no money to give you right now. Anyone here needing a kidney?",
		"I'm broke, please don't hate me, I love you!",
		"I'm broke and can't help, what are the organs I can live without???",
		"I have no money to help but I will try to contact people from the black market and sell some of my organs right now!",
		"I love you, I'll die for you, just order me! \n"+stamps["smile_1"],
		"I'm your slave, order me and I'll do anything!!! \n"+stamps["smile_3"],
		"I have no money to help you right now, but I'll have my little daughter sell her body right now!",
		"Please get some kidneys from the fans. I'd do anything!!",
		"I would sell my eyes for you, then I would kill myself because seeing you is the only thing that makes me keep going!",
		"Seriously wanna murder these degenerates in chat right now \n"+stamps["angry_1"],
		"I'm fucking finding and murdering the next scumbag that says anything negative about our queen \n"+stamps["angry_2"],
		"I shall hunt down my queen's enemies \n"+stamps["angry_3"]
		
		
		
		
	]
	
	var gatikoi_jp = [
		"あなたに無視されるたびに1円もらえたら、君にプレゼントを買えるくらいお金が貯まってたね。でも、君のグッズに全財産使っちゃったからね。夢の中で生き続けるしかないかな。",
		"君がメッセージに返信しない理由がわかった。完璧すぎて、僕のささやかなメッセージに気づく暇がないんだろうね。僕はただ、君のデジタルの偉大さの影で生きてるよ。",
		"メッセージを送っても返信がないのって面白いね。君はブラックホールみたいだね。どれだけ愛を送っても全部吸い込まれて消えちゃうんだね。やめないけどね！",
		"君が僕に気づいてくれる日を夢見てる。それまで、コメント欄でデジタルのダンジョンに囚われた吟遊詩人みたいに君にセレナーデを送るよ。",
		"部屋に君のための神殿を作ったよ。写真とキャンドルがメインなんだけど、きっとラブレターと同じようなものだよね、ただしお香が多いだけで。",
		"僕たちは平行線みたいだね。絶対に交わらない運命。でも心配しないで、曲線を描くのが得意になってきたから！",
		"毎日君の星占いを読んでるんだ。いつも『執着心の強いストーカーに注意』って書いてあるけど、大丈夫、僕はただ暇が多いだけさ！",
		"愛は盲目って言うけど、よかった。君の顔を何時間も見つめてたら、目が痛くなってきたよ。",
		"君のことを思うたびに1ドルもらえたら、君の隣の家を買っちゃうかも…いや、同じ街に。",
		"君についての詩を書いたんだ。タイトルは『夢に出てくる女神へのオード』。ちょっと感動的で、怖くないから安心して！",
		"新しい植物に君の名前を付けたんだ。君が成長する様子を見るのが楽しみで。えっと、今回は水やりすぎないように気をつけるね。",
		"君のために歌を書いたよ！タイトルは『なぜ僕の存在を無視するの？』ちょっと重たい感じだけど…",
		"今日、部屋の模様替えをしたんだ。これで、起きたときと寝る前に君の顔が見える。ほとんど一緒に住んでるみたいだね！",
		"コーヒーが好きって投稿してたよね？君のためにカプチーノを作ったよ、泡がまるで接近禁止命令みたいに。",
		"君にバラを12本買ったんだ。今は11本しかないけど、1本は枯れちゃったんだ。僕たちの関係みたいに。でも大丈夫、涙で水やりしておくよ。",
		"君の名前を付けた猫を飼ったんだ。彼女も僕を無視するんだよ！",
		"君が僕の運命の人だって分かるのは、君に送ったラブレターの数が仮釈放の手紙より多いからさ。",
		"今日、君の名義で献血したんだ。いつか輸血が必要になった時のためにね。誰かのためにここまでできるなんて！",
		"1年間、毎日メッセージを送ってるけど、無言が響いてるよ。政府は僕たちが付き合ってるって思ってるかも。😂",
		"君は流れ星みたいだね。短くて、美しくて、手の届かない存在。",
		"君が僕たちは一緒になれないって言ったのは知ってるけど、楽観的でいようと思ったんだ。だって、タイタニックだって生存者はいたからね。",
		"セラピストに現実的な目標を立てるように言われたんだ。だから、君と結婚するのじゃなくて、君から接近禁止命令をもらうのを目指すことにしたよ。",
		"君のことを考えるたびに1ドルもらえたら、きっと君を忘れるためのセラピーを買えるだろうね。",
		"僕たちについての歌を書いたよ。タイトルは『想像上の彼女』。僕の頭の中ではヒット間違いなしだよ！",
		"Wi-Fiの名前を君にしたんだ。友達がパスワードを聞いてきたら、君にアクセスできないのと同じだって答えるんだ。",
		"僕の携帯も君のこと好きなんだ。毎日メッセージ送るたびにバッテリーが切れちゃうんだ！",
		"どんなに悪い日でも、君は素晴らしい人だよ。元気出してね！",
		"君は一人じゃないよ。僕がここにいるから！",
		"あなたの強さとたくましさに毎日勇気をもらっています。自分がどれだけ素晴らしいか、忘れないでね！",
		"大きなバーチャルハグを送るよ。きっと乗り越えられるよ！",
		"あなたの優しい心と強い魂は本当に素晴らしい。どんなことがあっても、その輝きを失わないで。",
		"君の笑顔は部屋を明るくするよ。それを奪われないでね！",
		"あなたは思っている以上に愛されています。頑張って！",
		"内面も外見も美しいよ。自分を信じて！",
		"助けを求めるのは大丈夫だよ。一人で抱え込まなくていいんだよ。",
		"自分が思っている以上に強いんだから、きっと乗り越えられるよ。",
		"今日の問題で明日の太陽を隠さないで。君ならできる！",
		"君の勇気と決意に感動してる。前に進み続けてね。",
		"君は素晴らしい人で、世界にたくさんのものを与えられるんだから、何があってもくじけないで！",
		"君は美しい魂の持ち主で、世界中の幸せを受け取る価値があるんだよ。",
		"君の笑顔は暗い日でも明るくするんだ。笑顔を絶やさないでね！",
		"これまでたくさんの困難を乗り越えてきたんだから、これからも頑張って！",
		"この旅で君は一人じゃないよ。いつでもここにいるから。",
		"うまくいかないと感じる時でも、君は素晴らしい仕事をしているよ。",
		"君にはどんなことでも乗り越えられる強さがあるよ。自分を信じて！",
		"君は戦士だから、きっと乗り越えられるよ。前に進み続けて！",
		"君の強さとたくましさに感動してる。諦めないで！",
		"君の心は愛で満ちていて、魂は強い。進み続けて！",
		"君にはこれを乗り越える力があるよ。自分を信じて！",
		"君を信じてるよ。君ならできる！",
		"これまで困難な時を乗り越えてきたんだから、今回も乗り越えられるよ。",
		"君が頑張ってることに本当に誇りに思ってるよ。戦い続けて！",
		"君の笑顔は曇りの日に太陽みたいだよ。",
		"ポジティブなエネルギーを送るよ。君ならできる！",
		"いつでもここにいるからね。",
		"君のポジティブさと強さはみんなに伝わってるよ。",
		"君にはこれを乗り越える力がある。信じてるよ。",
		"君の忍耐力は本当に尊敬するよ。",
		"君は世界にたくさんの光をもたらしてるよ。輝き続けて！",
		"困難を乗り越えるたびに君は強くなるよ。",
		"君は素晴らしい人で、僕はいつも応援してるよ。",
		"自分がどれだけ素晴らしいか、忘れないでね。君ならできる！",
		"ごめんね、今お金がなくて。でも、何かできることがあれば何でもするよ！",
		"お金がなくて助けられないけど、君のこと愛してるから、どうか許して！",
		"今お金がなくて何もできないけど、何かできる方法を探すから待っててね。",
		"お金がないけど、何かの手助けになるならどんなことでもするから！",
		"君のためなら命を捧げるよ。何でも言って！",
		"僕達は君の奴隷だよ。何でも命令して！",
		"今お金がないけど、何かできることがあれば何でもやるよ。",
		"ファンのみんなに助けを求めるよ。君のためなら何でもするから！",
		"君のためなら目を売ってもいい。そして君を見れなくなるくらいなら、いっそ死んでも構わない！",
	]
	
	var rng = RandomNumberGenerator.new()
	
	if sexual_harasment_.is_empty():
		sexual_harasment_ = sexual_harasment
	if sekuhara_.is_empty():
		sekuhara_ = sekuhara
	if gatikoi_en_.is_empty():
		gatikoi_en_ = gatikoi_en
	if gatikoi_jp_.is_empty():
		gatikoi_jp_ = gatikoi_jp
	
	var demographic
	
	if group == "random":
		var odds = rng.randi_range(1,10)
		if glob.idiom == "English":
			if glob.Save["random_chat_odds"] < odds:
				demographic = perverts
			else:
				demographic = gatikois_en
				
		if glob.idiom == "Japanese":
			if glob.Save["random_chat_odds"] < odds:
				demographic = hentais
			else:
				demographic = gatikois_jp
	
	if group == "perverts":
		demographic = perverts
	
	if group == "gatikois_en":
		demographic = gatikois_en
		
	if group == "hentais":
		demographic = hentais
		
	if group == "gatikois_jp":
		demographic = gatikois_jp
	
	var chatter = demographic[rng.randi_range(0,demographic.size()-1)]
	
	if chatter in perverts:
		sexual_harasment_.shuffle()
		var message = chatter+sexual_harasment_.pop_front()
		relay_chat.emit(glob.TranslationWrapper(message))
		return message
	
	if chatter in hentais:
		sekuhara_.shuffle()
		var message = chatter+sekuhara_.pop_front()
		relay_chat.emit(glob.TranslationWrapper(message))
		return message
		
	if chatter in gatikois_en:
		gatikoi_en_.shuffle()
		var message = chatter+gatikoi_en_.pop_front()
		relay_chat.emit(glob.TranslationWrapper(message))
		return message
		
	if chatter in gatikois_jp:
		gatikoi_jp_.shuffle()
		var message = chatter+gatikoi_jp_.pop_front()
		relay_chat.emit(glob.TranslationWrapper(message))
		return message
	
func buy_default(item : String) -> void:
	if !glob.Save.has("NumberOfBought"+item):
		glob.Save["NumberOfBought"+item] = 0
	
	var price = int($ScrollContainer/ShopItemsListing.get_node(item).get_node("ShopItem").get_node("Price").text)
	if glob.Save["Money"] - price < 0:
		$ScrollContainer/ShopItemsListing/ProblemWarning.DisplayText = "Not enough money!"
		$ScrollContainer/ShopItemsListing/ProblemWarning.roll_text()
		return
	glob.Save["ItemBox"].append(item)
	glob.Save["NumberOfBought"+item] = int(glob.Save["NumberOfBought"+item]) +1
	glob.Save["Money"] = glob.Save["Money"] - price
	$Money.text = str(glob.Save["Money"])
	$ScrollContainer/ShopItemsListing/ProblemWarning.DisplayText = "-"+str(price)
	$ScrollContainer/ShopItemsListing/ProblemWarning.roll_text()

func _on_random_chat_delay_timeout():
	if !AutoChat:
		return
	push_chat()
	var random_message = filler_message_generator()
	$ChatControl/Chat/s1/RichTextLabel.text = random_message
	var rng = RandomNumberGenerator.new()
	$RandomChatDelay.wait_time = rng.randi_range(5,12)

func _on_panel_mode_relay_chat(message: String) -> void:
	push_chat()
	$ChatControl/Chat/s1/RichTextLabel.text = message

func char_motion_matching(pos : Vector3) -> void:
	var z = 259.68 * pos.z + 137.63
	var x = 44.07 * pos.x + 365.92
	var s = -0.0992 * pos.x + 0.1966
	z = (z/(x/100))
	z = 0.975*z+960
	#print(str(z))
	var r = Vector2(z, x)
	$Control/SubViewportContainer/SubViewport/CharSprite.position = r
	$Control/SubViewportContainer/SubViewport/CharSprite.scale = Vector2(s,s)
	#print(str($Control/SubViewportContainer/SubViewport/CharSprite.position)+" "+str($Control/SubViewportContainer/SubViewport/CharSprite.scale))
