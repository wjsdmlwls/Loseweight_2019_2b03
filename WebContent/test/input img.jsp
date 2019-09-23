<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
	<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
	
	<script src="js/jquery.MultiFile.js"></script>
	<script>
	
		$(function(){ // wait for page to load
		  $('input.afile3').MultiFile({
			max: 3, //업로드 최대 파일 갯수 (지정하지 않으면 무한대)
			accept: 'jpg|png|gif', //허용할 확장자(지정하지 않으면 모든 확장자 허용)
			maxfile: 1024, //각 파일 최대 업로드 크기
			maxsize: 3024,  //전체 파일 최대 업로드 크기
			STRING: { //Multi-lingual support : 메시지 수정 가능
				remove : "제거", //추가한 파일 제거 문구, 이미태그를 사용하면 이미지사용가능
				duplicate : "$file 은 이미 선택된 파일입니다.", 
				denied : "$ext 는(은) 업로드 할수 없는 파일확장자입니다.",
 			    selected:'$file 을 선택했습니다.', 
				toomuch: "업로드할 수 있는 최대크기를 초과하였습니다.($size)", 
				toomany: "업로드할 수 있는 최대 갯수는 $max개 입니다.",
				toobig: "$file 은 크기가 매우 큽니다. (max $size)"
			},
			list:"#afile3-list" //파일목록을 출력할 요소 지정가능
			
			//각각의 이벤트에 따라 스크립 처리를 할수있다.
			/*
			,onFileRemove: function(element, value, master_element) {
			  $('#afile3-list').append('<li>onFileRemove - ' + value + '</li>')
			},
			afterFileRemove: function(element, value, master_element) {
			  $('#afile3-list').append('<li>afterFileRemove - ' + value + '</li>')
			},
			onFileAppend: function(element, value, master_element) {
			  $('#afile3-list').append('<li>onFileAppend - ' + value + '</li>')
			},
			afterFileAppend: function(element, value, master_element) {
			  $('#afile3-list').append('<li>afterFileAppend - ' + value + '</li>')
			},
			onFileSelect: function(element, value, master_element) {
			  $('#afile3-list').append('<li>onFileSelect - ' + value + '</li>')
			},
			afterFileSelect: function(element, value, master_element) {
			  $('#afile3-list').append('<li>afterFileSelect - ' + value + '</li>')
			},
			onFileInvalid: function(element, value, master_element) {
			  $('#afile3-list').append('<li>onFileInvalid - ' + value + '</li>')
			},
			onFileDuplicate: function(element, value, master_element) {
			  $('#afile3-list').append('<li>onFileDuplicate - ' + value + '</li>')
			},
			onFileTooMany: function(element, value, master_element) {
			  $('#afile3-list').append('<li>onFileTooMany - ' + value + '</li>')
			},
			onFileTooBig: function(element, value, master_element) {
			  $('#afile3-list').append('<li>onFileTooBig - ' + value + '</li>')
			},
			onFileTooMuch: function(element, value, master_element) {
			  $('#afile3-list').append('<li>onFileTooMuch - ' + value + '</li>')
			}
			*/

		  });

		});
	</script>
<!--slide-->
<body>

 1.  <input type="file" class="multi with-preview" multiple />
 
 
 <input type="file" class="afile3 with-preview" />
 <div id="afile3-list" style="border:2px solid #c9c9c9;min-height:50px"></div>
 <br/>
</body>
</html>