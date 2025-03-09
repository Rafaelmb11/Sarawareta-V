extends Node3D

@onready var camera = $Camera3D
@onready var togTween = 1
@onready var block_input_till = Time.get_ticks_msec()
@onready var time = 2
@onready var stream_screen2 = load("res://Sprites/Backgrounds/stream_screen2.jpg")
@onready var youkai_screen = load("res://Sprites/Backgrounds/youkai_screen.png")
@onready var coomFlash = load("res://Scenes/screen_flash.tscn")
@onready var coomInstance = coomFlash.instantiate()
@onready var runBefore1 = false
@onready var glob = get_node("/root/globals")

#region Text
@onready var TextBlock1 = [
	"りりたん | 「こんリリ！みんなー、お元気ですか？今日は新衣装お披露目の日ですよー！」",
	"ファットアッス | 「りりたんかわいい、はー、りりたんのおっぱい！はーはー。」",
	"りりたん | 「りりたんの新しいエッチエッチな衣装をみたいですかー？勿論みたいですよね！意地悪でごめんなさいですぅぅ…」",
	"りりたん | 「でもー、こんな早く見せたらさー、おもしろくないですよねー！」",
	"ファットアッス | 「りりたんの意地悪ー！みせて、エッチエッチなすがたを！はー、りりたんのパンツは何色なのかな、知りたい…クンクンしたい…」",
	"りりたん | 「まー自裁、他のコンテンツは良いされてませんけどねー、適当でごめんねみんなー」",
	"りりたん | 「あー、今おぼえましたが、告知があります！」",
	"りりたん | 「あのね、これはちょっと恥ずかしいですけど、新しいグッズ販売します！」",
	"りりたん | 「このグッズの招待はね…リリたんのパンツからラボで総合されましたりりたんパンツアロマですー！」",
	"ファットアッス | 「うおおおおおー！！！ほしいいいいい！！」",
	"りりたん | 「凄くはずかしいんですけど、でも、皆はりりたんのパンツをクンクンしたいよねー、だから、皆のために恥ずかしさを我慢しましたよ、リリたんえらい！」",
	"りりたん | 「あと、一個あたりはたったの５万ですよ！五胡ぐらい買おうねー！」",
	"ファットアッス | 「高けぇぇ！でも、凄くほしいいいい。」",
	"りりたん | 「でわ、お待ちかねの新衣装お披露目ですぅぅ！」",
	"ファットアッス | 「ワクワク」",
	"りりたん | 「きゃー、この衣装はちょっと小さすぎったみたい！嫌だ嫌だ、みないでー！」",
	"ファットアッス | 「TKB！！！」",
	"りりたん ｜ 「バン？皆は知らないのか？じゃ、りりたんが教えますね。」",
	"りりたん | 「実はね、海外のフェッミどもがね、”女だけ乳首を見せられないのは差別です！”とよく吠えんだおかげでね、先日に乳首出しはOKになりました！」",
	"りりたん | 「フェッミどもに感謝してよね皆ー！こいつらが臭くってでも、気持ち悪くってでも、かんしゃをー！」",
	"ファットアッス | 「汚いフェッミどもへ、ありがとうございました！！！」",
	"りりたん | 「でもね、政敵なコンテンツはまだ禁止のままなの、だから、皆が４５４５すればりりたんがバンされちゃうかもしれないから、ちゃんと我慢してね,一応アイドルだからねー。」",
	"ファットアッス | 「シコシコ」",
	"りりたん | 「お披露目は終ったけど、でもまだとじちゃだめー。皆今日だけはりりパンアロマを10個買えったら、特別にエチエチなお人形さんをただでついかしまーす！」",
	"りりたん | 「君がいっぱい買えなかったら、りりたんのおっぱいが縮むんだよ、分かった？！」",
	"ファットアッス | 「シコシコ」",
	"りりたん | 「皆ー！チャットがちょっと気持ち悪いよ、だめだよこんな。りりたんは清楚だよ、こんなエッチな目でみちゃだめだぞー。」",
	"ファットアッス | シコシコ",
	"りりたん | 「どうしてちょっとだけファンサをするとこうなるんだよー！もう、みんなエッチー！」",
	"ファットアッス | 「イクウウウー！」",
	"ファットアッス | 「あー、画面が…まー、どうでもいいか。それよりも、ちんぽが収まる要素がない！」",
	"りりたん | 「でわ、今日のところはこのぐらいでー、来週にはASMR配信があるので、いっぱい溜まってお楽しみにしてねー！バイバイ。」",
	"ファットアッス | 「足りない！もっと見たい、りりたんの中身が見たい、やばい、ちんぽが収まらない、もう無理！」",
	"ファットアッス | 「りりたん、ごめん！この手段だけは使いたくなかったけど、でもそうしないと、ちんぽが永遠におさまらない！」",
	"YouKaiとはダークウェッブサイトである、彼らが提供するサービスは女配信者の誘拐と捕囚であり。",
	"誘拐された女の子は監視カメラまみれの部屋で過ごす事になる、プライバシーなーし！そう、これは凌辱配信闇サイトの被害者募集中な状態だった！",
	"ファットアッス | 「りりたんの中の人の凌辱配信かー。見たい！凄く見たい！金がやばいが、でも、見たい！払うしかないよなー！」",
	"ファットアッス | 「又おばーちゃんから借りようかなー。」",
]

#endregion

# Called when the node enters the scene tree for the first time.
func _ready():
	tog_coom_on_screen(false)
	queue_text(TextBlock1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	breathingEffect()
	if $Textbox.getDisplayedText() == "「きゃー、この衣装はちょっと小さすぎったみたい！嫌だ嫌だ、みないでー！」":
		$Decal.texture_albedo = stream_screen2
		
	if $Textbox.getDisplayedText() == "「イクウウウー！」" && !runBefore1:
		self.add_child(coomInstance)
		runBefore1 = true
		
	if $Textbox.getDisplayedText() == "「りりたん、ごめん！この手段だけは使いたくなかったけど、でもそうしないと、ちんぽが永遠におさまらない！」":
		$Decal.texture_albedo = youkai_screen
		
	if $Textbox.getPreviousTextOnDisplay() == "「又おばーちゃんから借りようかなー。」":
		var image = get_viewport().get_texture().get_image() # We get what our player sees
		glob.setImage(image)
		glob.previousScene = "intro"
		get_tree().change_scene_to_file("res://main.tscn")
		
	
	if coomInstance.get_node("Cooming").almostdone():
		tog_coom_on_screen(true)
		
			
			
	
func breathingEffect():
	if !cooldown_check():
		return
	if togTween == 1:
		var tween = get_tree().create_tween()
		tween.tween_property(camera, "rotation", Vector3(camera.rotation.x+0.02, camera.rotation.y-0.01, camera.rotation.z-0.01), time)
	if togTween == 2:
		var tween = get_tree().create_tween()
		tween.tween_property(camera, "rotation", Vector3(camera.rotation.x-0.02, camera.rotation.y+0.01, camera.rotation.z+0.01), time)
	if togTween == 3:
		var tween = get_tree().create_tween()
		tween.tween_property(camera, "rotation", Vector3(camera.rotation.x-0.03, camera.rotation.y-0.01, camera.rotation.z+0.01), time)
	if togTween == 4:
		var tween = get_tree().create_tween()
		tween.tween_property(camera, "rotation", Vector3(camera.rotation.x+0.03, camera.rotation.y+0.01, camera.rotation.z-0.01), time)
		
	togTween = togTween+1
	if togTween > 4:
		togTween = 1
	block_input_till = Time.get_ticks_msec() + time*1000
	var rand = RandomNumberGenerator.new()
	time = rand.randf_range(2, 5)

	
func cooldown_check():
	if Time.get_ticks_msec() > block_input_till:
		return true
	else:
		return false
		
func queue_text(text):
	$Textbox.playText(text)
	
func tog_coom_on_screen(visibility : bool):
	$intro_room/Cube_005.visible = visibility
	$intro_room/Cube_006.visible = visibility
	$intro_room/Cube_007.visible = visibility
	
