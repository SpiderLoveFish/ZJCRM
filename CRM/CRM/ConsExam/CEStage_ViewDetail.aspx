<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <script src="../../lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
    <link href="../../lib/ligerUI/skins/ext/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/input.css" rel="stylesheet" type="text/css" />
     <script src="../../lib/ligerUI/js/plugins/ligerCheckBox.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerTree.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerLayout.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerDialog.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerDrag.js" type="text/javascript"></script>
    <script src="../../JS/XHD.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerTextBox.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerToolBar.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerMenu.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerComboBox.js" type="text/javascript"></script>
    <script src="../../lib/jquery.form.js" type="text/javascript"></script>

    <script type="text/javascript">
        var manager = "";
        var treemanager;
        $(function () {
            $("#khstext").ligerTextBox();
            $("#khstext").val(getparastr("name"))
            $("#sgjlstext").ligerTextBox(); $("#sgjlstext").val(getparastr("sgjl"))
            $("#dclstext").ligerTextBox(); $("#dclstext").val(getparastr("dcl"))
            $("#khzfstext").ligerTextBox(); $("#khzfstext").val(getparastr("zf"))
            $("#khdzstext").ligerTextBox(); $("#khdzstext").val(getparastr("adress"))


            $("#maingrid4").ligerGrid({
                    columns: [
                    { display: '���', width: 50, render: function (rowData, rowindex, value, column, rowid, page, pagesize) { return (page - 1) * pagesize + rowindex + 1; } },
                     
                    { display: '������Ŀ', name: 'CEStage_category', width: 160 },
                    { display: '��������', name: 'TotalScorce', width: 100 },
                    //{ display: '�����', name: 'StageID', width: 60 },
                    //{ display: '�����', name: 'dcl', width: 100 },
                      { display: '���˴���', name: 'ver', width: 100 }
                   

                    ],
            dataAction: 'server',
            url: "../../data/Crm_CEStage.ashx?Action=viewgrid&pid=" + getparastr("pid") + "&rnd=" + Math.random(),
            pageSize: 30,
                pageSizeOptions: [20, 30, 50, 100],
                width: '100%',
                height: '100%',
                heightDiff: -1,
                onRClickToSelect: true,
                detail: {
                    onShowDetail: function (r, p) {
                        for (var n in r) {
                            if (r[n] == null) r[n] = "";
                        }
                        var grid = document.createElement('div');
                        $(p).append(grid);
                        $(grid).css('margin', 3).ligerGrid({
                            columns: [
                                    { display: '���', width: 30, render: function (item, i) { return i + 1; } },
                                     { display: '��Ŀ���', name: 'projectid', width: 60 },
                                      { display: '��������', name: 'CEStage_category', width: 120 },
                                   // { display: '�汾��', name: 'versions', width: 60 },
                                    // { display: '�������', name: 'isChecked', width: 80 },
                                      // { display: '�Ƿ�᰸', name: 'IsClose', width: 80 },
                                    { display: '���˽��', name: 'AssTime', width: 60, type: 'float' },
                                     { display: '����ʱ��', name: 'Cdate', width: 100, type: 'date' },
                                     {
                                         display: '�鿴����', width: 100, render: function (item) {
                                             var html = "<a href='javascript:void(0)' onclick=view(" + item.StageID + "," + item.versions + ",'" + item.CEStage_category + "')>�鿴</a>"
                                             //," + item.StageID + ",'" + item.CEStage_category + "'
                                             return html;
                                         }
                                     }

                            ],
                            usePager: false,
                            checkbox: false,
                            url: "../../data/CRM_CEDetail.ashx?Action=Acgrid&pid=" + getparastr("pid") + "&sid=" + r.stageid,
                            width: '99%', height: '100',
                            heightDiff: 0
                        })
                    }

                }
            });
            initLayout();
            $(window).resize(function () {
                initLayout();
            });

        });
        
 
        
        function f_openWindow(url, title, width, height) {
            var dialogOptions = {
                width: width, height: height, title: title, url: url, buttons: [
                         
                        {
                            text: '�ر�', onclick: function (item, dialog) {
                                dialog.close();
                            }
                        }
                ], isResize: true, showToggle: true, timeParmName: 'a'
            };
            activeDialog = parent.jQuery.ligerDialog.open(dialogOptions);
        }

 
        //�鿴 
        function view(sid,vid,name) {

            f_openWindow('crm/ConsExam/CEDetail_View.aspx?&sid=' + sid + '&pid=' + getparastr("pid")+'&vid='+vid+'&sname='+name, "�鿴����", 790, 500);
              }

 
 
      

         
 
        function f_load() {
            var manager = $("#maingrid4").ligerGetGridManager();
            manager.loadData(true);

            //treemanager = $("#tree1").ligerGetTreeManager();
            //treemanager.clear();
            //treemanager.FlushData();
        }

       
    </script>
   
</head>
<body style="padding: 0px;overflow:hidden;">
    <table align="left" border="0" cellpadding="3" cellspacing="1" class="bodytable1">
           
      <tr>
                    <td>
                        <div style='width: 60px; text-align: right; float: right'>�ͻ�����</div>
                    </td>
                    <td>

                        <input  ltype='text' ligerui='{width:100,disabled:true}' type='text' id='sgjlstext' name='sgjlstext'  /></td>

                    <td>
                        <div style='width: 60px; text-align: right; float: right'>�����ܷ֣�</div>
                    </td>
                    <td>
                        <div style='width: 100px; float: left'>
                            <input type='text' id='khzfstext' name='khzfstext' ltype='text' ligerui='{width:100,disabled:true}'  />
                        </div>
                    
                    </td>
                    <td>
                        <div style='width: 60px; text-align: right; float: right'>����ʣ�</div>
                    </td>
                    <td>
                        <div style='width: 100px; float: left'>
                            <input type='text' id='dclstext' name='dclstext'   ltype='text' ligerui='{width:100,disabled:true}'  />
                        </div>
                       
                    </td>
                    
                </tr>
                <tr>
                    <td>
                        <div style='width: 60px; text-align: right; float: right'>�ͻ�������</div>
                    </td>
                    <td> 
                           <input type='text' id='khstext' name='khstext'   ltype='text' ligerui='{width:100,disabled:true}'  />
                    
                    </td>

                    <td>
                        <div style='width: 60px; text-align: right; float: right'>�ͻ���ַ��</div>
                    </td>
                    <td colspan="4">
                      <input type='text' id='khdzstext' name='khdzstext'  ltype='text' ligerui='{width:300,disabled:true}' />
                     
                </td>
                     
                     

                </tr>
            
            


        </table>
     
    <form id="form1" onsubmit="return false">
         
            <div position="center">
              
                <div id="maingrid4" style="margin: -1px;"></div>
            </div>
        
    </form>
</body>
</html>
