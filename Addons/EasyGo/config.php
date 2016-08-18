<?php
return array(
	'group'=>array(
		'type'=>'group',
		'options'=>array(
			'color1'=>array(
				'title'=>'颜色选择器1',
				'options'=>array(
					'Color1_Event'=>array(
						'title'=>'字体是否显示颜色',
						'type'=>'radio',
						'options'=>array(		 //select 和radion、checkbox的子选项
							'click'=>'click(默认)',		 //值=>文字
							'mouseover'=>'mouseover',
							'focus'=>'focus'
						),
						'value'=>'click'
					),
				)
			),
			'color2'=>array(
				'title'=>'颜色选择器2',
			),
			'date1'=>array(
				'title'=>'日期选择器1',
				'options'=>array(
					'Date1_color'=>array(
						'title'=>'颜色:',
						'type'=>'radio',
						'options'=>array(		 //select 和radion、checkbox的子选项
							'red'=>'红色',		 //值=>文字
							'green'=>'绿色',
							'blue'=>'蓝色',
							'yellow'=>'黄色',		 
							'black'=>'黑色'
						),
						'value'=>'red'
					),
					'Date1_Event'=>array(
						'title'=>'触发事件:',
						'type'=>'radio',
						'options'=>array(		 //select 和radion、checkbox的子选项
							'click'=>'点击输入框弹出',		 //值=>文字
							'focus'=>'获得焦点弹出',
							'mouseover'=>'鼠标移入弹出'
						),
						'value'=>'click',
						'tip'=>'默认是点击'
					),
					'Date1_DateFormat'=>array(
						'title'=>'日期格式:',
						'type'=>'radio',
						'options'=>array(		 //select 和radion、checkbox的子选项
							'yyyy-MM-dd'=>'2013-10-1',		 //值=>文字
							'yyyy/MM/dd'=>'2013/10/1',
							'yyyy年MM月dd日'=>'2013年10月1日',
							'MM-dd'=>'10-1（只有月日）',
							'dd'=>'1（只有天）'
						),
						'value'=>'click',
						'tip'=>'这里以2013-10-1为例'
					),
					'Date1_Left'=>array(
						'title'=>'距离输入框Left距离:',
						'type'=>'text',
						'value'=>'0',
						'tip'=>'距离输入框left(默认0)'
					),
					'Date1_Top'=>array(
						'title'=>'距离输入框Top距离:',
						'type'=>'text',
						'value'=>'8',
						'tip'=>'距离输入框top(默认8)'
					),
					'IsNeedClickOk'=>array(
						'title'=>'是否必然要点击确认键:',
						'type'=>'radio',
						'options'=>array(		 //select 和radion、checkbox的子选项
							'true'=>'是',		 //值=>文字
							'false'=>'否',
						),
						'value'=>'false',
						'tip'=>'默认为否'
					),
					'Animate'=>array(
						'title'=>'是否必然要点击确认键:',
						'type'=>'radio',
						'options'=>array(		 //select 和radion、checkbox的子选项
							'0'=>'无动画(默认)',		 //值=>文字
							'1'=>'滑出滑入',
							'2'=>'渐入渐出'
						),
						'value'=>'0',
					),
				)
			),
			'map1'=>array(
				'title'=>'地图选择器1',
				'options'=>array(
					'map1_show'=>array(
						'title'=>'a标签文字内容',
						'type'=>'text',
						'value'=>'去地图中选择',
						'tip'=>'默认是：去地图中选择，如果设置自己的样式，可以设置为空然后在下面设置样式'
					),
					'map1_style'=>array(
						'title'=>'a标签的样式',
						'type'=>'textarea',
						'value'=>'',
						'tip'=>'设置a标签的样式，请直接写样式，不要写<style></style>,如：margin:0;font-size:10px;'
					),
				)
			),
		)
	)
);
					