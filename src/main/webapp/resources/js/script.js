$(document).ready(function() {
	lists();
	Listcombo();
});

/*method lists() get all data from database show on table*/

function lists(){	
	$.ajax({
		url : "index.sarin",
		success : function(data) {
			$("#listcontent").html(createTable(data));
		}
	});
	
}

/*method ListClass(data) for create combobox search */

function ListClass(data){ 
	var str="";
	str+="<option value=''>----Select Class---</option>";
	for(var i=0;i<data.length;i++){
		str+="<option value='"+data[i].stuclass+"'>"+ data[i].stuclass+"</option>";
	}
	return str;
}

/*method Listcombo() get StudClass from database  */

function Listcombo(){
	$.post("ListCombo.sarin", {
	}, function(data) {
		$("#searchclass").html(ListClass(data));
	});
}

/*method createTable(data)  for  create table and loop data from json insert into table */

function createTable(data) {
	var str="";
	for (var i = 0; i < data.length; i++) {
		str += "<tr>" + "<td id=studid" + i + ">" + data[i].stuid + "</td>"
				+ "<td>" + data[i].stuname + "</td>" + "<td>"
				+checkgender(data[i].stugender) + "</td>" + "<td>" + data[i].stuuniversity
				+ "</td>" + "<td>" + data[i].stuclass + "</td>" + "<td style='text-align:center;'>"
				+ changestatus(data[i].stustatus,data[i].stuid) + "</td><td style='text-align:center;'>"+ actionbutton(data[i].stuid, data[i].stuname,data[i].stugender,data[i].stuuniversity,data[i].stuclass,data[i].stustatus) +"</td></tr>";
	}
	return str;
}

/*method actionbutton for  load button Edit and button edit into table*/

function actionbutton(stuid,stuname,stugender,univer,stuclass,stustatus){
	var btn="<div class='form-group'>";
	btn+="<button type='button' class='btn btn-success' stuid='"+stuid+"' stuname='"+stuname+"' stugender='"+stugender+"'  stuuniversity='"+univer+"' stuclass='"+stuclass+"' stustatus='"+stustatus+"' onclick='EditOption(this)'>";		
	btn+="<span class='glyphicon glyphicon-edit'></span></button><span style='margin-left:10px'></span>";
	btn+="<button type='button' class='btn btn-danger' stuid='"+stuid+"' onclick='DeleteOption(this)'>";
	btn+="<span class='glyphicon glyphicon-trash'></span></button></div>";
	return btn;
}

/*method DeleteOption(data) for  delete Student information*/

function DeleteOption(data){
	var stuid=$(data).attr("stuid");
	$.post("delete.sarin", {
		stu_id : stuid,
	}, function(data) {
		lists();
		Listcombo();
	});
}

/*method searchClass() for  search Student Class*/

function searchClass(){
	var stuname = $("#search").val();
	var stuclass = $('#searchclass option:selected').val();
	var stustatus=$('#searchstatus option:selected').val();
	if (stuclass == "") {
		lists();
	}
	$.post("searchstudent.sarin", {
		stu_name : stuname,
		stu_class : stuclass,
		stu_status : stustatus,
	}, function(data) {
		$("#listcontent").html(createTable(data));
	});
}

/*method searchStatus() for  search Student status*/

function searchStatus(){
	var stuname = $("#search").val();
	var stuclass = $('#searchclass option:selected').val();
	var stustatus=$('#searchstatus option:selected').val();
	if (stustatus == "") {
		lists();
	}
	$.post("searchstudent.sarin", {
		stu_name : stuname,
		stu_class : stuclass,
		stu_status : stustatus,
	}, function(data) {
		$("#listcontent").html(createTable(data));
	});
}

/*method Add() for  Add new information of Student */

function Add(){
	var stuname = $("#stuname").val();
	var stugender=$("#stugender option:selected").val();
	var stuuniversity=$("#stuuniver option:selected").val();
	var stuclass = $("#stuclass").val();
	var stustatus = $("#stustatus option:selected").val();
	if(stuname=="" || stugender=="" || stuuniversity=="" || stuclass=="" || stustatus==""){
		alert("Data is empty");
		return;
	}
	else{
	$.post("add.sarin", {
		stu_name : stuname,
		stu_gender : stugender,
		stu_university : stuuniversity,
		stu_class : stuclass,
		stu_status : stustatus,
	}, function(data) {
		lists();
		Listcombo();
	});
	}
	clear();
}

/*method searchName() for  search Student name*/

function searchName(){
	var stuname = $("#search").val();
	var stuclass = $('#searchclass option:selected').val();
	var stustatus = $('#searchstatus option:selected').val();
	if (stuname == "") {
		lists();
	}
	$.post("searchstudent.sarin", {
		stu_name : stuname,
		stu_class : stuclass,
		stu_status : stustatus,
	}, function(data) {
		$("#listcontent").html(createTable(data));
	});
}

/*method checkgender for change value to Male Or Female*/

function checkgender(data){
	var str='';
	if(data=="1"){
		str="Male";
	}
	else{
		str="Female";
	}
	return str;
}

/*method changestatus for change value to Icon Active  Or Deactive*/

function changestatus(data,id){ 
	var str="";
	if(data==1){
		str+="<a style=' cursor:pointer;'><img src='img/1.png' style='width:30px;height:30px' id='status' status='"+data+"' stuid='"+id+"' onclick='checkstatus(this)' /></a>";
	}
	else{
		str+="<a style='cursor:pointer;'><img src='img/0.png' style='width:30px;height:30px' id='status' status='"+data+"' stuid='"+id+"' onclick='checkstatus(this)' /></a>";
	}
	return str;
}

/*method checkstatus for  upadate status on databases*/

function checkstatus(data){
	 var status=$(data).attr("status");
	 var stuid=$(data).attr("stuid");
	 if(status==1){
		 status=0;
	 }
	 else{
		 status=1;
	 }
	 $.post("check.sarin", {
			stu_id : stuid,
			stu_status : status,
		}, function(data2) {
			searchStatus();
		});
}

/*method EditOption for  get value from database  insert into from element*/

function EditOption(data){
	 $("#stuid").val($(data).attr("stuid"));
	 $("#stuname").val($(data).attr("stuname"));
	 $("#stugender").val($(data).attr("stugender"));
	 $("#stuuniver").val($(data).attr("stuuniversity"));
	 $("#stuclass").val($(data).attr("stuclass"));
	 $("#stustatus").val($(data).attr("stustatus"));
	 $("#add").val("Update");
	 $("#add").attr("onclick","update()");
}

/*method update() for  update infromation of student */

function update(){
	var stuid=$("#stuid").val();
	var stuname = $("#stuname").val();
	var stugender=$("#stugender option:selected").val();
	var stuuniversity=$("#stuuniver option:selected").val();
	var stuclass = $("#stuclass").val();
	var stustatus = $("#stustatus").val();
	$.post("update.sarin", {
		stu_id	: stuid,
		stu_name : stuname,
		stu_gender : stugender,
		stu_university : stuuniversity,
		stu_class : stuclass,
		stu_status : stustatus,
	}, function(data) {
		lists();
	});
	 $("#add").val("Add");
	 $("#add").attr("onclick","Add()");
	 clear();
}

/*method Cancel() for  cancel function Add() and update() */

function Cancel(){
	clear();
	 if($("#add").val()=="Update"){
	 $("#add").val("Add");
	 $("#add").attr("onclick","add()");
	 }
}

/*method clear() for clear  value of element form  */

function clear(){
	 $("#stuid").val("");
	 $("#stuname").val("");
	 $("#stugender").val("");
	 $("#stuuniver").val("");
	 $("#stuclass").val("");
	 $("#stustatus").val("");
}

