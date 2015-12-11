<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ page isELIgnored="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Student Information</title>

<script src="${pageContext.request.contextPath}/resources/js/jquery-1.9.1.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/angular.min.js"></script>

<link href="${pageContext.request.contextPath}/resources/css/bootstrap.css" rel="stylesheet">


<!-- internal style  -->
<style>
 th{text-align: center;}
 @media screen and (max-width: 600px) {
    #tablerepone {
        overflow: scroll;
    }
}
#status,#option{
	text-align: center;
}
#status img{
	width:35px;
	cursor:pointer;	
}
td a{
	margin:10px;
}
</style>


</head>
<body>
	<div class="">
	<center><h1>USER REGISTER</h1></center>
	
		<!-- Form for add new information -->
		
	    
	    <!-- End of Form for add new information -->
	    
		<div class="col-sm-12">
		<div ng-app="myApp" ng-controller="planetController">  
			<div class="panel panel-info">						
				<!-- Div Table for show information -->
				<div class="panel-body"  id="tablerepone" >
				
				<form>
						 <div class="form-group" >
							<label>User ID: </label>
							<input type="text" class="form-control" name="id" id="id"   readonly="readonly">
						</div>
						<div class="form-group">
							<label>Username: </label>
							<input type="text" class="form-control" name="user_name" id="user_name" placeholder="Username"  >
						</div>
						
						<div class="form-group">
							<label>Email: </label>
							<input type="email" class="form-control" name="email" id="email" placeholder="email" >
						</div>
						
						<div class="form-group">
							<label>Password: </label>
							<input type="password" class="form-control" name="password" id="password" placeholder="password" >
						</div>
						<div class="form-group">
							<label>BirthDate: </label>
							<input type="date" class="form-control" name="birthdate" id="birthdate" placeholder="birthdate" >
						</div>
						
						<div class="form-group">
							<label>RegisterDate: </label>
							<input type="date" class="form-control" name="registerdate" id="registerdate" placeholder="registerdate" >
						</div>
						<div class="form-group">
							<label>Image: </label>
							<input type="text" class="form-control" name="image" id="image" placeholder="image" >
						</div>																																							
						
						<div class="form-group" style="margin-left:20%;">
							<input type="button" class="btn btn-success"  value="ADD" id="btnupdate" >
							<input type="reset" class="btn btn-info" id="clear"  value="Cancel">							
						</div>
						
		      </form>
				
			<form class="form-inline pull-right" role="form">  
				<div class="form-group">    					
    					<input type="text" class="form-control" id="search">
  				</div>
			</form>
				
				<br/><br/>			                 
					<table id="listcontent" class="table table-striped table-bordered table-hover table-condensed" ></table>
				
				<!-- End of div Table for show information -->
			</div>
			</div>
		    </div>
		</div>
	</div>
	<script type="text/javascript">		
	$(document).ready(function(){
		 var el ="${pageContext.request.contextPath}";
		 
		/* function for delete user  */
		$('body').on('click', '.del', function(){			
			var othis=$(this);			   	
				$.ajax({  
			          url:el+"/api/delete/"+$(this).attr("stuid"),  
			          type:'DELETE',	       
			          success: function(data) {  			    	   			    	 
			    	  othis.parents('tr').remove();
			          console.log("Success..." + data);
			     }}); 
		});
		/* fucntion get data for update  */
		  $('body').on('click', '.update', function(){	
			 // $("#btnupdate").attr("style","display:grid");
			  $("#btnupdate").val("Update");
			var othis=$(this);			   	
				$.ajax({  
			          url:el+"/api/update/"+othis.attr("stuid"),  
			          type:'get',	       
			          success: function(data) {  
			        	  getValueIntextBox(data);
			          console.log("Success..." + data);
			     }});  
			     
		}); 
		  /* fucntion get data for view  */
		  $('body').on('click', '.view', function(){				 
			  $("#btnupdate").val("ADD");
			  var othis=$(this);		   	
				$.ajax({  
			          url:el+"/api/update/"+othis.attr("stuid"),  
			          type:'get',	       
			          success: function(data) {  
			          getValueIntextBox(data);
			          console.log("Success..." + data);
			     }}); 
		}); 
	
		  /* fucntion  for add and update user if value = ADD action add , value = other action update */
		  $('body').on('click', '#btnupdate', function(){			
			var othis=$(this);
			var id=$("#id").val();
			var user_name=$("#user_name").val();
			var email=$("#email").val();
			var password=$("#password").val();
			var registerdate=$("#registerdate").val();
			var birthdate=$("#birthdate").val();
			var image=$("#image").val();
			
			var JSONObject= {
					"id": id,
		            "user_name":user_name,
		            "email":email,
		            "password":password,
		            "birthdate":birthdate,
		            "registerdate":registerdate,
		            "image":image
		    };
			if(othis.val()=="ADD"){
				$.ajax({  
				      url:'${pageContext.request.contextPath}/add/',  
				      type:'post',
				      contentType: 'application/json;charset=utf-8', // type of data
//				       dataType: 'JSON',
				      data: JSON.stringify(JSONObject), // make JSON string
//				       crossDomain: true,
				      success: function(data) { 
//				                var jsonData = $.parseJSON(data); //if data is not json
				                list();			
				                clearTextbox()
				               console.log("Success..." + data);
				      }}); 
			}
			else{
				$.ajax({  
			          url:el+"/api/update",  
			          type:'put',	
			          contentType: 'application/json;charset=utf-8', // type of data
			          data: JSON.stringify(JSONObject), // make JSON string
			          success: function(data) {  
			            list();			
			            clearTextbox()
			        	othis.val("ADD");
			          console.log("Success..." + data);
			     }});
			}
			
			
				 
		}); 
		
		  /* function search username by keyup event */
		$('body').on('keyup', '#search', function(){			
			var othis=$(this).val();	
			if(othis==""){
				list();
			}
			else{
				 $.ajax({  
			          url:el+"/api/search/"+othis,  
			          type:'GET',	  			    
			          success: function(data) {  
			        $("#listcontent").html(createTable(data));
			          console.log("Success..." + data);
			     }}); 
			}
			    
		});
		
	});
	
	list();	
	/* function for list all user  */
	function list(){
	 $.ajax({  
        url:'${pageContext.request.contextPath}/list',  
        type:'get',
        contentType: 'application/json;charset=utf-8', // type of data
       success: function(data) {          	   
               $("#listcontent").html(createTable(data));               
              console.log("Success..." + data);
     }}); 
     
		}
	/* function for createtable list user */
	function createTable(data) {
		var str="";
			str+="<thead><tr>"+
			"<th>ID</th>"+
			"<th>USER NAME</th>"+
			"<th>EMAIL</th>"+
			"<th>PASSWORD</th>"+
			"<th>BIRTHDATE</th>"+
			"<th>REGISTERDATE</th>"+
			"<th>IMAGE</th>"+
			"<th>ACTION</th>"+
		    "</thead>";
		for (var i = 0; i < data.RESPONSE_DATA.length; i++) {
			str += "<tbody><tr><td>"+ data.RESPONSE_DATA[i].id + "</td>"+ 
					"<td>"   + data.RESPONSE_DATA[i].user_name  + "</td>"+
					"<td>"   + data.RESPONSE_DATA[i].email  + "</td>"+
					"<td>"   + data.RESPONSE_DATA[i].password  + "</td>"+
					"<td>"   + data.RESPONSE_DATA[i].birthdate  + "</td>"+
					"<td>"   + data.RESPONSE_DATA[i].registerdate  + "</td>"+
					"<td>"   + data.RESPONSE_DATA[i].image  + "</td>"+
					"<td style='width:22%'>"   + actionButton(data.RESPONSE_DATA[i].id)+ 
					"</td></tr></tbody>";										
		}
		return str;
	} 
	
	/* function forgatvalue to textbox  */
	function getValueIntextBox(data){
		$("#id").val(data.RESPONSE_DATA[0].id);
      	$("#user_name").val(data.RESPONSE_DATA[0].user_name);
      	$("#email").val(data.RESPONSE_DATA[0].email);
      	$("#password").val(data.RESPONSE_DATA[0].password);
      	$("#birthdate").val(data.RESPONSE_DATA[0].birthdate);
      	$("#registerdate").val(data.RESPONSE_DATA[0].registerdate);
      	$("#image").val(data.RESPONSE_DATA[0].image);
	}
	
	/* function for clear textbox after add and update event */
	function clearTextbox(){
		 $("#id").val("");
     	$("#user_name").val("");
     	$("#email").val("");
     	$("#password").val("");
     	$("#birthdate").val("");
     	$("#registerdate").val("");
     	$("#image").val("");
	}
		/* function create action button update view delete */
	function actionButton(id){
		 var str="";		 
		 str+="<a class='btn btn-default update' stuid="+id+">Update</a>";		
		 str+="<a class='btn btn-success view' stuid="+id+">View</a>";		 
		 str+="<a class='btn btn-danger del'  stuid="+id+">DELETE</a>";
		return str; 
	}
	</script>
</body>
</html>