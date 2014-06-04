<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>jQuery Submit a form without postback</title>
   
    <script src="http://code.jquery.com/jquery.min.js" type="text/javascript"></script>
    <link href="http://getbootstrap.com/dist/css/bootstrap.css" rel="stylesheet" type="text/css" />
    <script src="http://getbootstrap.com/dist/js/bootstrap.js" type="text/javascript"></script>
    <link href="Styles/notifIt.css" rel="stylesheet" type="text/css" />
    
<script src="JQGridReq/notifIt.js" type="text/javascript"></script>
</head>
<body>
<div class="container">
    <form id="form1" runat="server" class="form-horizontal" role="form">
    <br />
    <div class="form-group">
        <label class="col-md-2 control-label" for="txtName">
            Name</label>
        <div class="col-md-6">
            <input type="text" class="form-control" id="txtname" placeholder="Enter Name" />
        </div>
    </div>
    <div class="form-group">
        <label class="col-md-2 control-label" for="txtSubject">
            Subject</label>
        <div class="col-md-6">
            <input type="text" class="form-control" id="txtsubject" placeholder="Enter Subject" />
        </div>
    </div>
    <div class="form-group">
        <label class="col-md-2 control-label" for="txtBody">
            Body :</label>
        <div class="col-md-6">
            <textarea id="txtbody" class="form-control" cols="20" rows="2" placeholder="Enter Body"></textarea><br />
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-offset-2 col-sm-10">
            <input type="button" class="btn btn-primary" id="btnSubmit" value="Submit" />
            <input type="button" class="btn btn-primary" id="btnSubmit1" value="SubmitviaJSONObject" />
        </div>
    </div>

   <%-- <label id="lblmsg" style="font-weight: bold; color: Red" />
   --%>
   

   <div class="container">
   <div class="well">
    <table class="table table-bordered" id="grdResults">
        <tr>
            <th>
                Name
            </th>
            <th>
                Subject
            </th>
            <th>
                Body
            </th>
        </tr>
    </table>
    </div>
</div>



    </form>
</div>




<script type="text/javascript">

    ///Code For Showing Process...
//        jQuery.ajaxSetup({
//            beforeSend: function () {
//                $('#lblmsg').html("Started")
//            },
//            complete: function () {
//                $('#lblmsg').html("completed")
//               
//            },
//            success: function () { $('#lblmsg').html("done") }
//        });

        



        $(function () {
            $('#btnSubmit').click(function () {
                var name = $('#txtname').val();
                var subject = $('#txtsubject').val();
                var body = $('#txtbody').val();
                if (name != '' && subject != '' && body) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "Default.aspx/InsertData",
                        data: "{'username':'" + name + "','subj':'" + subject + "','desc':'" + body + "'}",
                        dataType: "json",
                        success: function (data) {
                            var obj = data.d;
                            if (obj == 'true') {
                                $('#txtname').val('');
                                $('#txtsubject').val('');
                                $('#txtbody').val('');

                                notif({
                                    msg: "<b>Details Submitted Successfully</b> In 5 seconds i'll be gone",
                                    type: "success"
                                });
                                $('#lblmsg').html("Details Submitted Successfully");
                            }
                        },
                        error: function (result) {
                            alert("Error");
                        }
                    });
                }
                else {
                    alert('Please enter all the fields')
                    return false;
                }
            })


            $('#btnSubmit1').click(function () {
                var name1 = $('#txtname').val();
                var subject1 = $('#txtsubject').val();
                var body1 = $('#txtbody').val();

                $('#grdResults').append('<tr><td>'+name1+'</td><td>'+subject1+'</td><td>'+body1+'</td></tr>')

                var emp = {};
                emp.username = name1;
                emp.subject = subject1;
                emp.desc = body1;
                if (name1 != '' && subject1 != '' && body1) {
                    $.ajax({                    
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "Default.aspx/InsertDataUsingJSONObj",
                        data: "{empdata:" + JSON.stringify(emp) + "}",
                        dataType: "json",
                        success: function (data) {
                            var obj = data.d;
                            if (obj == 'true') {
                                $('#txtname').val('');
                                $('#txtsubject').val('');
                                $('#txtbody').val('');
                                notif({
                                    msg: "<b>Details Submitted Successfully</b> In 5 seconds i'll be gone",
                                    type: "success"
                                });
                            }
                        },
                        error: function (result) {
                            alert("Error");
                        }

                    });
                }
                else {
                    alert('Please enter all the fields')
                    return false;
                }
            })

        });
    </script>
</body>
</html>
