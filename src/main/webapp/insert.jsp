<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta charset="UTF-8">
	<title>Title</title>
	
    <script src="assets/js/croppie.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.0/jquery.validate.js"></script>
	
</head>
<body>
	
    <div class="container">
		
<br>
<p></p>

	                    <div>User Register</div>
	                        <form id="userRegister">
	                            <div>
	                                <label>ID</label>
	                                <div>
	                                    <input type="text" id="id" class="form-control" name="id">
	                                </div>
	                            </div>
	                            
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
	                                <button type="submit" class="btn btn-success">
	                                    Add
	                                </button>
	                                <a href="edit_n_delete.jsp" class="btn btn-success">
	                                    List
	                                </a>
	                            </div>
	                    	</form>
	                    </div>

</body>
</html>
<script>

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
        	    "id" : $('#id').val(),
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
                type: "POST",
                url: 'rest_api/user',
                dataType : 'json',
				contentType : 'application/json',
				data: fromData,
                success: function(data){
                	console.log(data);
                	if(data['success']=="Done"){
                		alert("Added Successfull!");
                        $("#userRegister")[0].reset();
					}else{
						alert("Unsuccessfull!");
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

</script>