<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>


<style>
h1 {
color: black;
box-shadow: #500e0e 0 0 20px 0px;
background-color: #ffd700b8;
padding: 10px;
text-align: center;
}
h2{
color: black;
box-shadow: #500e0e 0 0 20px 0px;
background-color: #ffd700b8;
padding: 10px;
text-align: center;
}
input[type=text], select {
width: 100%;
padding: 12px 20px;
margin: 8px 0;
display: inline-block;
border: 1px solid #ccc;
border-radius: 4px;
box-sizing: border-box;
}input[type=submit] {
width: 100%;
background-color: #4CAF50;
color: white;
padding: 14px 20px;
margin: 8px 0;
border: none;
border-radius: 4px;
cursor: pointer;
}input[type=submit]:hover {
background-color: #45a049;
}div {
border-radius: 5px;
background-color: #6748481c;
padding: 20px;
}
</style>



<head>
	<meta charset="UTF-8">
	<title>title</title>
	
    
    <script src="assets/js/croppie.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.0/jquery.validate.js"></script>
	
</head>
<body>
	
    <div class="container">
		
<br>
<p></p>
	                    <h1>Users List</h1>
	                    <div>
	                        <div id="usersDiv">
	                    	
	            			</div>
	                    </div>
	                    
	                   
<div id="hideDiv" style="display: none">
                             <h2>Users List</h2>
   	                        <form id="userRegister">
							<input type= "hidden" id="edit_id" name="edit_id">
	                            
	                            <div>
	                                <label>First Name</label>
	                                <div>
	                                    <input type="text" id="fname" class="form-control" name="fname">
	                                </div>
	                            </div>
	                            
	                            <div>
	                                <label>Last Name</label>
	                                <div>
	                                    <input type="text" id="lname" class="form-control" name="lname">
	                                </div>
	                            </div>
	                            
	                            <div>
	                                <label>Phone Number</label>
	                                <div>
	                                    <input type="number" id="mobile" class="form-control" name="mobile">
	                                </div>
	                            </div>
	                            
	                            <div>
	                                <label>E-mail</label>
	                                <div>
	                                    <input type="email" id="email" class="form-control" name="email">
	                                </div>
	                            </div>
	                            
	                           
	                            
	                             <div>
	                                <label>NIC Number</label>
	                                <div>
	                                    <input type="number" id="nic" class="form-control" name="nic">
	                                </div>
	                            </div>
	                            
	                             <div>
	                                <label>Address</label>
	                                <div>
	                                    <input type="text" id="address" class="form-control" name="address">
	                                </div>
	                            </div>
	                           
	                            <div>
	                                <label>Password</label>
	                                <div>
	                                    <input type="password" id="password" class="form-control" name="password">
	                                </div>
	                            </div>
	                            
	                             <div>
	                                <label>Account Number</label>
	                                <div>
	                                    <input type="number" id="account_number" class="form-control" name="account_number">
	                                </div>
	                            </div>
	                            
	                            <div>
	                             
										<input type="submit" value="Edit">

	                               
	                                
	                            </div>
	                    	</form>
</div> 
	                    
</div>
	
</body>
</html>

<script>

    function deletes(id) {
    	if (confirm("Delete ?") == true) {
        	$.ajax({
                type: "DELETE",
                url: "rest_api/user",
                data: JSON.stringify({ 'id' : id}),
                dataType: "json",
    			contentType : 'application/json',
                success: function(data){
                	if(data['success']=="Done"){
                		alert("Delete Successfull!");
    					reload();
    				}else if(data['success']=="0"){
    					alert("Delete Unsuccessful!");
    				}
                },
                failure: function(errMsg) {
                    alert('Error');
                }
            });
    	}
    }

    $(document).ready(function () {

    	   $("#userRegister").validate({
    	        rules: {
    	        	id: "required",
    	        	fname: "required",
    	        	lname: "required",
    	        	mobile: "required",
    	        	email: {
    	                email: true,
    	                required: true
    	            },
    	        	nic: "required",
    	        	address: "required",
    	            password: "required",
    	        	account_number: "required"
    	        },
    	        messages: {
    	        	id: "N Required!",
    	        	fname: "F Required!",
    	        	lname: "l Required!",
    	        	mobile: "m Required!",
    	        	email: {
    	                email: "format",
    	                required: "required"
    	            },

    	        	nic: "n Required!",
    	        	address: "a Required!",
    	        	password: "p Required!",
    	        	account_number: "a Required!"
    	        },
    	        submitHandler: function () {
    	        	var fromData = JSON.stringify({
    	        		"id" : $('#edit_id').val(),
    	                "fname" : $('#fname').val(),
    	                "lname" : $('#lname').val(),
    	                "mobile" : $('#mobile').val(),
    	                "email" : $('#email').val(),
    	                "nic" : $('#nic').val(),
    	                "address" : $('#address').val(),
    	                "password" : $('#password').val(),
    	                "account_number" : $('#account_number').val()
    	            });
            	
            	console.log(fromData);

                $.ajax({
                    type: "PUT",
                    url: 'rest_api/user',
                    dataType : 'json',
    				contentType : 'application/json',
    				data: fromData,
                    success: function(data){
                    	if(data['success']=="Done"){
                    		alert("Edit Successfull!");
                        	document.getElementById("hideDiv").style.display = "none";
                            $("#userRegister")[0].reset();
    						reload();
    					}else{
    						alert("Unsuccessful!");
    					}
                    },
                    failure: function(errMsg) {
                    	alert("Connection Error!");
                    }
                });
            }
        });

        $("#userRegister").submit(function(e) {
            e.preventDefault();
        });

    });

    function reload(){
    	$.ajax({
            type: "GET",
            url: "rest_api/user",
            success: function(data){
            	$("#usersDiv").html(data);
            },
            failure: function(errMsg) {
                alert('Error');
            }
        });
    }

    reload();
    
    function edit(id) {
    	document.getElementById("hideDiv").style.display = "block";
    	$.ajax({
            type: "POST",
            url: "rest_api/user/get",
            data: JSON.stringify({ 'id' : id}),
            dataType: "json",
			contentType : 'application/json',
            success: function(data){
            	console.log(data),
                $('#edit_id').val(data['id']),
                $('#fname').val(data['fname']),
                $('#lname').val(data['lname']),
                $('#mobile').val(data['mobile']),
                $('#email').val(data['email']),
                $('#nic').val(data['nic']),
                $('#address').val(data['address']),
                $('#password').val(data['password']),
                $('#account_number').val(data['account_number'])
            },
            failure: function(errMsg) {
                alert('Error');
            }
        });

    }
    
    
</script>