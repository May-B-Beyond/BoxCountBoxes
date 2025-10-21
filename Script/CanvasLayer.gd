extends CanvasLayer


@onready var line_edit: LineEdit = $LineEdit
@onready var sfx_coin = $"../sfx_coin"
@onready var correct_answer = $"../Correct_Answer"
@onready var time_spending = $TimeSpending


var input_Text : String = ""
'''Timer
'''
var start_time: float = 0.0
var end_time: float = 0.0
var answer_time: float = 0.0
var showTime: float = 0.0
		
func _ready():
	line_edit.text_submitted.connect(_on_Line_text_entered)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	showTime = (Time.get_ticks_msec()-end_time)/1000
	time_spending.text = str(showTime)
	
func _on_Line_text_entered(new_text : String) -> void:
	input_Text = line_edit.text
	line_edit.text = ""
	#print(Globals.Box_Count) #debugจ้า
	
	if(int(input_Text) == Globals.Box_Count):
		
		Globals.Score += 1
		Globals.reset_box = true
		end_time = Time.get_ticks_msec()
		answer_time = (end_time - start_time) / 1000.0
		Globals.Averagetimetook = (Globals.Averagetimetook+answer_time)/2
		#print( Globals.Averagetimetook)
		start_time = Time.get_ticks_msec()
		sfx_coin.play() #sfx เหรียญ
		correct_answer.play() #sfx ตอบถูก
		
	else:
		
		Globals.reset_box = true
	
