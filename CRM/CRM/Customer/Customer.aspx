<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <meta http-equiv="X-UA-Compatible" content="IE=7" />
    <link href="../../CSS/core.css" rel="stylesheet" type="text/css" />
    <link href="../../lib/ligerUI/skins/ext/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/input.css" rel="stylesheet" />

    <script src="../../lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerLayout.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerForm.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerCheckBox.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerComboBox.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerDateEditor.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerRadio.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerTextBox.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerSpinner.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerTree.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerDialog.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerDrag.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerResizable.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerTip.js" type="text/javascript"></script>
    <script src="../../lib/jquery.form.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerToolBar.js" type="text/javascript"></script>
        <script src="../../JS/Toolbar.js" type="text/javascript"></script>
    <script src="../../JS/XHD.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerMenu.js" type="text/javascript"></script>
    <script type="text/javascript">
        var manager; var gg;
        var manager1;
        var IsExistTelRight;
        $(function () {
            var customerIdSelected; //��¼��ǰѡ��������еĿͻ�ID
            initLayout();
            $(window).resize(function () {
                initLayout();
            });

            IsExist_TelRight();
            $("#ck").ligerCheckBox();
            var gridurl = "../../data/crm_customer.ashx?Action=grid&type=0&rnd=" + Math.random();
            if (getparastr("type") == "TEMP")//�����ͻ�
            { gridurl = "../../data/crm_customer.ashx?Action=grid&type=2&rnd=" + Math.random(); }
           else  if (getparastr("type") == "CX")//��ѯ�ͻ�
            {
                gridurl = "../../data/crm_customer.ashx?Action=grid&CType=" + encodeURI(decodeURI(getparastr("CType"))) + "&kh=" + encodeURI(decodeURI(getparastr("kh"))) + "&khtype=" + getparastr("sectype") + "&searchtype=" + getparastr("searchtype")+"&rnd=" + Math.random();
            }
            
            if (getparastr("type") == "GJXG") {
                gg = $("#maingrid4").ligerGrid(
               {

                   columns: [
                       {
                           display: '���', width: 30, render: function (rowData, rowindex, value, column, rowid, page, pagesize)
                           { return (page - 1) * pagesize + rowindex + 1; }
                       },
                   { display: '���', name: 'khbh', width: 60 },
                       {
                           display: '����', name: 'Customer', width: 50, align: 'left', render: function (item) {
                               var html = "<a href='javascript:void(0)' onclick=view(1," + item.id + ")>";
                               if (item.Customer)
                                   html += item.Customer;
                               html += "</a>";
                               return html;
                           }
                       },
                       { display: '�Ա�', name: 'Gender', width: 40 },
                        {
                            display: '�绰', name: 'tel', align: 'left', width: 40, render: function (item) {
                                var html = "<div class='abc'>";
                                if (item.tel)
                                {
                                    if (IsExistTelRight == 1)
                                        html += item.tel;
                                    else { html = "*********"; }
                                  //  else { html += item.tel; }
                                }
                                  
                                html += "</div>";
                                return html;
                            }
                        },
                      {
                          display: '��ַ', name: 'address', align: 'left', width: 120, render: function (item) {
                              var html = "<div class='abc'>";
                              if (item.address)
                                  html += item.address;
                              html += "</div>";
                              return html;
                          }
                      },
                       { display: 'С��', name: 'Community', width: 60 },


                       {
                           display: '�ͻ�����', name: 'CustomerType', width: 60, align: 'right', render: function (item) {
                               return "<span><div  style='background:#" + item.setcolor + "'>" + item.CustomerType + "</div></span>";
                           }
                       },
                           {
                               display: '�ͻ�״̬', name: 'industry', width: 60, align: 'right', render: function (item) {
                                   return "<span><div style='color:#" + item.indcolor + "'>" + item.industry + "</div></span>";
                               }
                           },

                       //{ display: 'ʡ��', name: 'Provinces', width: 80 },
                       //{ display: '����', name: 'City', width: 80 },
                       //{ display: '����', name: 'Towns', width: 80 },
                       //{ display: '¥��', name: 'BNo', width: 80 },
                       //{ display: '����', name: 'RNo', width: 80 },

                      // { display: '����', name: 'Department', width: 80 },
                       { display: 'ҵ��Ա', name: 'Employee', width: 50 },
                       { display: '���ʦ', name: 'Emp_sj', width: 50 },
                       { display: 'ʩ������', name: 'Emp_sg', width: 60 },
                        {
                            display: '��ǰ�׶�', name: 'Stage_icon', width: 60, render: function (item) {

                                var html;
                                if (item.Stage_icon == "δǩ��") {
                                    html = "<div style='color:#FF0000'>";
                                    html += item.Stage_icon;
                                    html += "</div>";
                                }
                                else if (item.Stage_icon == "��ǩ��") {
                                    html = "<div style='color:#339900'>";
                                    html += item.Stage_icon;
                                    html += "</div>";
                                }
                                else if (item.Stage_icon == "����ʩ��") {
                                    html = "<div style='color:#FF0000'>";
                                    html += item.Stage_icon;
                                    html += "</div>";
                                }
                                else if (item.Stage_icon == "ʩ�����") {
                                    html = "<div style='color:#339900'>";
                                    html += item.Stage_icon;
                                    html += "</div>";
                                }
                                else {
                                    html = item.Stage_icon;
                                }
                                return html;
                            }
                        },
                         {
                             display: '�¸��׶�', name: 'Stage_icon', width: 60, render: function (item) {

                                 var html;


                                 if (item.Stage_icon == "��ǩ��") {
                                     html = "<div style='color:#FF0000'>";
                                     html += "����ʩ��";
                                     html += "</div>";
                                 }
                                 else if (item.Stage_icon == "����ʩ��") {
                                     html = "<div style='color:#339900'>";
                                     html += "ʩ�����";
                                     html += "</div>";
                                 }
                                 else if (item.Stage_icon == "ʩ�����") {
                                     html = "<div style='color:#000'>";
                                     html += "��";
                                     html += "</div>";
                                 }
                                 else if (item.Stage_icon == "δǩ��") {
                                     html = "<div style='color:#339900'>";
                                     html += "��ǩ��";
                                     html += "</div>";
                                 }
                                 else {
                                     html = item.Stage_icon;
                                 }
                                 return html;
                             }
                         },
                         {
                             display: 'Ч��ͼ', name: 'kjl', width: 60, render: function (item) {
                                 var html;

                                 if (item.kjl == "Y") {
                                     html = "<div style='color:#FF0000'>";
                                     html += "��";
                                     html += "</div>";
                                 }
                                 else {
                                     html = "<div style='color:#000'>";
                                     html += "��";
                                     html += "</div>";
                                 }
                                 return html;
                             }
                         },

                          {
                              display: 'Ӧ�ս��', name: 'Order_amount', width: 80, align: 'right', render: function (item) {
                                  return "<div style='color:#135294'>" + toMoney(item.Order_amount) + "</div>";
                              }
                          },
                           {
                               display: '���ն���', name: 'dj_amount', width: 80, align: 'right', render: function (item) {
                                   return "<div style='color:#135294'>" + toMoney(item.dj_amount) + "</div>";
                               }
                           },
                             {
                                 display: '����װ�޿�', name: 'zx_amount', width: 80, align: 'right', render: function (item) {
                                     return "<div style='color:#135294'>" + toMoney(item.zx_amount) + "</div>";
                                 }
                             },
                               {
                                   display: 'δ�ս��', name: 'wx_amount', width: 80, align: 'right', render: function (item) {
                                       return "<div style='color:#135294'>" + toMoney(item.Order_amount - item.dj_amount - item.zx_amount) + "</div>";
                                   }
                               },
                       { display: '����', name: 'privatecustomer', width: 40 },







                       {
                           display: '����ʱ��', name: 'Create_date', width: 90, render: function (item) {
                               var Create_date = formatTimebytype(item.Create_date, 'yyyy-MM-dd');
                               return Create_date;
                           }
                       },

                       {
                           display: '�޸�����', name: 'Delete_time', width: 90, render: function (item) {
                               var Delete_time = formatTimebytype(item.Delete_time, 'yyyy-MM-dd');
                               return Delete_time;
                           }
                       }
                       

                   ],

                   onBeforeShowData: function (grid, data) {
                       startTime = new Date();
                   },
                   //fixedCellHeight:false,
                   onSelectRow: function (data, rowindex, rowobj) {
                       customerIdSelected = data.id;
                       var manager = $("#maingrid5").ligerGetGridManager();
                       manager.showData({ Rows: [], Total: 0 });
                       var url = "";
                       if (getparastr("type") == "GJXG") //�ͻ����ȹ���
                       {
                           url = "../../data/CRM_receive.ashx?Action=grid_khjdgl&customerid=" + data.id;
                       }
                       else
                       {
                           url = "../../data/CRM_Follow.ashx?Action=grid&customer_id=" + data.id;
                       }
                       manager.GetDataByURL(url);
                   },
                   rowtype: "CustomerType",
                   dataAction: 'server', pageSize: 30, pageSizeOptions: [20, 30, 50, 100],
                   url: gridurl,
                   width: '100%', height: '65%', 
                   heightDiff: -1,
                   onRClickToSelect: true,
                   onContextmenu: function (parm, e) {
                       actionCustomerID = parm.data.id;
                       menu.show({ top: e.pageY, left: e.pageX });
                       return false;
                   },
                   onAfterShowData: function (grid) {
                       $("tr[rowtype='�ѳɽ�']").addClass("l-treeleve1").removeClass("l-grid-row-alt");
                       var nowTime = new Date();
                       //alert('�������ݺ�ʱ��' + (nowTime - startTime));
                   },
                   detail: {
                       onShowDetail: function (r, p) {
                           for (var n in r) {
                               if (r[n] == null) r[n] = "";
                           }
                           var grid = document.createElement('div');
                           $(p).append(grid);
                           $(grid).css('margin', 3).ligerGrid({
                               columns: [
                               { display: '�к�', width: 50, render: function (item, i) { return i + 1; } },
                               { display: '��ϵ��', name: 'C_name', width: 100 },
                               { display: 'ְҵ', name: 'C_position', width: 100 },
                               { display: '�Ա�', name: 'C_sex', width: 50 },
                               //{ display: '�ͻ�����', name: 'C_companyname', width: 180 },
                               { display: '�ֻ�', name: 'C_mob', width: 120 },
                               { display: 'QQ', name: 'C_QQ', width: 100 },
                               { display: 'Email', name: 'C_email', width: 180 }
                               ],
                               usePager: false,
                               checkbox: false,
                               url: "../../data/CRM_Contact.ashx?Action=grid&customerid=" + r.id,
                               width: '1022px', height: '100px',
                               heightDiff: 0
                           })

                       }
                   }
               });
            }
            else {
                gg = $("#maingrid4").ligerGrid(

                {

                    columns: [
                        {
                            display: '���', width: 30, render: function (rowData, rowindex, value, column, rowid, page, pagesize)
                            { return (page - 1) * pagesize + rowindex + 1; }
                        },
                     { display: '���', name: 'khbh', width: 60 },
                        {
                            display: '����', name: 'Customer', width: 50, align: 'left', render: function (item) {
                                var html = "<a href='javascript:void(0)' onclick=view(1," + item.id + ")>";
                                if (item.Customer)
                                    html += item.Customer;
                                html += "</a>";
                                return html;
                            }
                        },
                        { display: '�Ա�', name: 'Gender', width: 40 },
                         {
                             display: '�绰', name: 'tel', align: 'left', width: 40, render: function (item) {
                                 var html = "<div class='abc'>";
                                 if (item.tel) {
                                     if (IsExistTelRight == 1)
                                         html += item.tel;
                                     else { html = "*********"; }
                                     // else { html =  item.tel; }
                                 }
                                 html += "</div>";
                                 return html;
                             }
                         },
                       {
                           display: '��ַ', name: 'address', align: 'left', width: 120, render: function (item) {
                               var html = "<div class='abc'>";
                               if (item.address)
                                   html += item.address;
                               html += "</div>";
                               return html;
                           }
                       },
                        { display: 'С��', name: 'Community', width: 60 },


                        {
                            display: '�ͻ�����', name: 'CustomerType', width: 60, align: 'right', render: function (item) {
                                return "<span><div  style='background:#" + item.setcolor + "'>" + item.CustomerType + "</div></span>";
                            }
                        },
                            {
                                display: '�ͻ�״̬', name: 'industry', width: 60, align: 'right', render: function (item) {
                                    return "<span><div style='color:#" + item.indcolor + "'>" + item.industry + "</div></span>";
                                }
                            },
                                 // { display: '�ͻ�״̬', name: 'industry', width: 80 },
                        { display: 'Ԥ���λ', name: 'CustomerLevel', width: 60 },
                        { display: '�ͻ���Դ', name: 'CustomerSource', width: 60 },
                        //{ display: 'ʡ��', name: 'Provinces', width: 80 },
                        //{ display: '����', name: 'City', width: 80 },
                        //{ display: '����', name: 'Towns', width: 80 },
                        //{ display: '¥��', name: 'BNo', width: 80 },
                        //{ display: '����', name: 'RNo', width: 80 },

                       // { display: '����', name: 'Department', width: 80 },
                        { display: 'ҵ��Ա', name: 'Employee', width: 50 },
                        { display: '���ʦ', name: 'Emp_sj', width: 50 },
                        { display: 'ʩ������', name: 'Emp_sg', width: 60 },
                         {
                             display: '����', name: 'Stage_icon', width: 60, render: function (item) {

                                 var html;
                                 if (item.Stage_icon == "����ʩ��") {
                                     html = "<div style='color:#FF0000'>";
                                     html += item.Stage_icon;
                                     html += "</div>";
                                 }
                                 else if (item.Stage_icon == "ʩ�����") {
                                     html = "<div style='color:#339900'>";
                                     html += item.Stage_icon;
                                     html += "</div>";
                                 }
                                 else {
                                     html = item.Stage_icon;
                                 }
                                 return html;
                             }
                         },

                        { display: '����', name: 'privatecustomer', width: 40 },






                        {
                            display: '������', name: 'lastfollow', width: 150, render: function (item) {
                                var lastfollow = formatTimebytype(item.lastfollow, 'yyyy-MM-dd hh:mm');
                                if (lastfollow == "1900-01-01")
                                    lastfollow = "";
                                return lastfollow;
                            }
                        },
                       { display: '������׼', name: 'followhours', width: 60 }, 
                        {
                            display: 'δ��ʱ��', name: 'followtime', width: 90, render: function (item) {
                                var html;

                                  if (item.isfollowview == "0") {
                                      html = "<div style='color:#FF3030'>";
                                    html += item.followtime;
                                    html += "</div>";
                                }
                                  else  
                                  {
                                      html = "<div style='color:#339900'>";
                                html += item.followtime;
                                html += "</div>";
                                  }
                                return html;
                            }
                                 
                              
                        },
                        {
                            display: '�Ƿ�ʱ', name: 'isfollowview', width: 90, render: function (item) {
                                var html;

                                  if (item.isfollowview == "0") {
                                      html = "<div style='color:#FF3030'>";
                                    html += "�ѳ�ʱ";
                                    html += "</div>";
                                }
                                  else  
                                  {
                                      html = "<div style='color:#339900'>";
                                html += "δ��ʱ";
                                html += "</div>";
                                  }
                                return html;
                            }
                                 
                              
                        },
                        {
                            display: '����ʱ��', name: 'Create_date', width: 90, render: function (item) {
                                var Create_date = formatTimebytype(item.Create_date, 'yyyy-MM-dd');
                                return Create_date;
                            }
                        },

                        {
                            display: '�޸�����', name: 'Delete_time', width: 90, render: function (item) {
                                var Delete_time = formatTimebytype(item.Delete_time, 'yyyy-MM-dd');
                                return Delete_time;
                            }
                        }


                    ],

                    onBeforeShowData: function (grid, data) {
                        startTime = new Date();
                    },
                    //fixedCellHeight:false,
                    onSelectRow: function (data, rowindex, rowobj) {
                        var manager = $("#maingrid5").ligerGetGridManager();
                        manager.showData({ Rows: [], Total: 0 });
                        var url = "../../data/CRM_Follow.ashx?Action=grid&customer_id=" + data.id +"&sectype1=kh";
                        manager.GetDataByURL(url);
                    },
                    rowtype: "CustomerType",
                    dataAction: 'server', pageSize: 30, pageSizeOptions: [20, 30, 50, 100],
                    url: gridurl,
                    width: '100%', height: '65%',
                    heightDiff: -1,
                    onRClickToSelect: true,
                    onContextmenu: function (parm, e) {
                        actionCustomerID = parm.data.id;
                        menu.show({ top: e.pageY, left: e.pageX });
                        return false;
                    },
                    onAfterShowData: function (grid) {
                        $("tr[rowtype='�ѳɽ�']").addClass("l-treeleve1").removeClass("l-grid-row-alt");
                        var nowTime = new Date();
                        //alert('�������ݺ�ʱ��' + (nowTime - startTime));
                    },
                    detail: {
                        onShowDetail: function (r, p) {
                            for (var n in r) {
                                if (r[n] == null) r[n] = "";
                            }
                            var grid = document.createElement('div');
                            $(p).append(grid);
                            $(grid).css('margin', 3).ligerGrid({
                                columns: [
                                { display: '�к�', width: 50, render: function (item, i) { return i + 1; } },
                                { display: '��ϵ��', name: 'C_name', width: 100 },
                                { display: 'ְҵ', name: 'C_position', width: 100 },
                                { display: '�Ա�', name: 'C_sex', width: 50 },
                                //{ display: '�ͻ�����', name: 'C_companyname', width: 180 },
                                { display: '�ֻ�', name: 'C_mob', width: 120 },
                                { display: 'QQ', name: 'C_QQ', width: 100 },
                                { display: 'Email', name: 'C_email', width: 180 }
                                ],
                                usePager: false,
                                checkbox: false,
                                url: "../../data/CRM_Contact.ashx?Action=grid&customerid=" + r.id,
                                width: '1022px', height: '100px',
                                heightDiff: 0
                            })

                        }
                    }
                });
            }
            if (getparastr("type") == "GJXG") //�ͻ����ȹ���
 
                $("#maingrid5").ligerGrid({
                    columns: [
                        { display: '���', width: 50, render: function (item, i) { return i + 1; } },

                       
                       
                         {
                             display: '����', name: 'receive_direction_name', width: 60, render: function (item) {

                                 var html;


                                 if (item.receive_direction_name == "��װ�޿�") {
                                     html = "<div style='color:#00f'>";
                                     html += "��װ�޿�";
                                     html += "</div>";
                                 }
                                 else if (item.receive_direction_name == "��װ�޿�") {
                                     html = "<div style='color:#FF0000'>";
                                     html += "��װ�޿�";
                                     html += "</div>";
                                 }
                                 else if (item.receive_direction_name == "�ն���") {
                                     html = "<div style='color:#00f'>";
                                     html += "�ն���";
                                     html += "</div>";
                                 }
                                 else if (item.receive_direction_name == "�˶���") {
                                     html = "<div style='color:#FF0000'>";
                                     html += "�˶���";
                                     html += "</div>";
                                 }
                                 else if (item.receive_direction_name == "Ӧ��") {
                                     html = "<div style='color:#000'>";
                                     html += "Ӧ��";
                                     html += "</div>";
                                 }
                                 else {
                                     html = item.receive_direction_name;
                                 }
                                 return html;
                             }
                         },
                          {
                              display: '������', name: 'Receive_amount', width: 80, align: 'right', render: function (item) {

                                  var html;


                                  if (item.receive_direction_name == "Ӧ��") {
                                      html = "<div style='color:#000'>";
                                      html += toMoney(item.Receive_amount);
                                      html += "</div>";
                                  }
                                  else if (item.Receive_amount >= 0) {
                                      html = "<div style='color:#00f'>";
                                      html += toMoney(item.Receive_amount);
                                      html += "</div>";
                                  }
                                  else if (item.Receive_amount < 0) {
                                      html = "<div style='color:#FF0000'>";
                                      html += toMoney(item.Receive_amount);
                                      html += "</div>";
                                  }

                                  else {
                                      html = item.Receive_amount;
                                  }
                                  return html;
                              }
                          },
                        { display: '��ʽ', name: 'Pay_type', width: 100 },
                         { display: 'ƾ֤����', name: 'Receive_num', width: 140 },
                       
                        {
                            display: '������', width: 100, render: function (item) {
                                return item.C_depname + "." + item.C_empname;
                            }
                        },
                        {
                            display: '��������', name: 'Receive_date', width: 90, render: function (item) {
                                return formatTimebytype(item.Receive_date, 'yyyy-MM-dd');
                            }
                        },
                        { display: '¼����', name: 'create_name', width: 90 },
                       
                         {
                             display: '״̬', name: 'IsStatus', width: 60, render: function (item) {

                                 var html;


                                 if (item.IsStatus == "��ȷ��") {
                                     html = "<div style='color:#FF0000'>";
                                     html += "��ȷ��";
                                     html += "</div>";
                                 }
                                 else if (item.IsStatus == "��ȷ��") {
                                     html = "<div style='color:#00f'>";
                                     html += "��ȷ��";
                                     html += "</div>";
                                 }
                                 else if (item.IsStatus == "����") {
                                     html = "<div style='color:#999'>";
                                     html += "����";
                                     html += "</div>";
                                 }
                                 
                                 else {
                                     html = item.IsStatus;
                                 }
                                 return html;
                             }
                         },
                        {
                            display: '�鿴', width: 60, render: function (item) {
                                var html="";
                                if (item.receive_direction_name == "�ն���" || item.receive_direction_name == "�˶���" || item.receive_direction_name == "��װ�޿�" || item.receive_direction_name == "��װ�޿�")
                                {
                                    html = "<a href='javascript:void(0)' onclick=view(66," + customerIdSelected + "," + item.id + ")>�鿴</a>";
                                }
                                else if (item.receive_direction_name == "����" || item.receive_direction_name == "ǩ��" )
                                {
                                    html = "<a href='javascript:void(0)' onclick=view(44," + customerIdSelected + "," + item.id + ")>�鿴</a>";
                                }                           
                                return html;
                            }
                        }

                    ],
                    dataAction: 'server', pageSize: 30, pageSizeOptions: [20, 30, 50, 100],
                    //checkbox:true,
                    url: "../../data/CRM_receive.ashx?Action=grid_khjdgl&orderid=0&rnd=" + Math.random(),
                    width: '100%', height: '100%',
                    //title: "�տ���Ϣ",
                    heightDiff: -1,
                    onRClickToSelect: true,
                    onContextmenu: function (parm, e) {
                        actionCustomerID = parm.data.id;
                        menu1.show({ top: e.pageY, left: e.pageX });
                        return false;
                    }
                });
            else
            $("#maingrid5").ligerGrid({
                columns: [
                    { display: '���', width: 40, render: function (item, i) { return i + 1; } },
                 {
                             display: '��Դ', name: 'lx', width: 60, render: function (item) {
                                 var html;
                                 if (item.lx == "�ͻ�") {
                                     html = "<div style='color:#339900'>";
                                     html += item.lx;
                                     html += "</div>";
                                 }
                                 else if (item.lx == "�ۺ�") {
                                     html = "<div style='color:#FF0000'>";
                                     html += item.lx;
                                     html += "</div>";
                                 }
                                 else if (item.lx == "ά��") {
                                     html = "<div style='color:#CC0000'>";
                                     html += item.lx;
                                     html += "</div>";
                                 }
                               
                                 else {
                                     html = item.lx;
                                 }
                                 return html;
                             }
                         },
                        {
                            display: '��������', name: 'Follow', align: 'left', width: 400, render: function (item) {
                                var html = "<div class='abc'><a href='javascript:void(0)' onclick=view(2," + item.id + ")>";
                                if (item.Follow)
                                    html += item.Follow;
                                html += "</a></div>";
                                return html;
                            }
                        },
                        {
                            display: '����ʱ��', name: 'Follow_date', width: 140, render: function (item) {
                                return formatTimebytype(item.Follow_date, 'yyyy-MM-dd hh:mm');
                            }
                        },
                        { display: '������ʽ', name: 'Follow_Type', width: 60 },
                        {
                            display: '������', name: '', width: 80, render: function (item) {
                                return item.employee_name;
                            }
                        }
                ],
                onAfterShowData: function (grid) {
                    $(".abc").hover(function (e) {
                        $(this).ligerTip({ content: $(this).text(), width: 200, distanceX: event.clientX - $(this).offset().left - $(this).width() + 15 });
                    }, function (e) {
                        $(this).ligerHideTip(e);
                    });
                },
                dataAction: 'server', pageSize: 30, pageSizeOptions: [20, 30, 50, 100],
                //checkbox:true,
                url: "../../data/CRM_Follow.ashx?Action=grid&customer_id=0" + "&sectype1=kh",
                width: '100%', height: '100%',
                //title: "������Ϣ",
                heightDiff: -1,
                onRClickToSelect: true,
                onContextmenu: function (parm, e) {
                    actionCustomerID = parm.data.id;
                    menu1.show({ top: e.pageY, left: e.pageX });
                    return false;
                }
            });

            $("#grid").height(document.documentElement.clientHeight - $(".toolbar").height());
            $('form').ligerForm();
            if (getparastr("type") != "CX")//��ѯ�ͻ�
            toolbar();
        });
       

        var mid,mid2;
        if (getparastr("type") == "GJXG") {
            mid = 194;
            mid2 = 203;
        }
        
    else if (getparastr("type") == "TEMP") {
            mid = 205;
            mid2 = 203;
    }
        else {
            mid = 4;
            mid2 = 6;
        }

        function IsExist_TelRight()
        {
           
            $.ajax({
                type: "GET",
                url: "../../data/Sys_role.ashx", /* ע���������ֶ�ӦCS�ķ������� */
                data: { Action: 'IsExistTelRight',  rnd: Math.random() }, /* ע������ĸ�ʽ������ */
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                  
                    IsExistTelRight =  result;
             

                }
            });
        }

        function toolbar() {
            $.getJSON("../../data/toolbar.ashx?Action=GetSys&mid="+mid+"&rnd=" + Math.random(), function (data, textStatus) {
                //alert(data);
                var items = [];
                var arr = data.Items;
                for (var i = 0; i < arr.length; i++) {
                    arr[i].icon = "../../" + arr[i].icon;
                    items.push(arr[i]);
                }
                if (getparastr("type") == "GJXG") {
                    items.push({
                        type: 'textbox',
                        id: 'sectype',
                        name: 'sectype',
                        text: 'ɸѡ'
                    });
                    items.push({
                        type: 'textbox',
                        id: 'thtype',
                        name: 'thtype',
                        text: '�׶�'
                    });
                }
                else {
                    items.push({
                        type: 'textbox',
                        id: 'stype',
                        name: 'stype',
                        text: '����'
                    });


                    items.push({
                        type: 'textbox',
                        id: 'sbq',
                        name: 'sbq',
                        text: '��ǩ'
                    });
                }
                items.push({
                    type: 'textbox',
                    id: 'keyword1',
                    name: 'keyword1',
                    text: ''
                });
                items.push({ line: true });
                items.push({
                    type: 'button',
                    text: '����',
                    icon: '../../images/search.gif',
                    disable: true,
                    click: function () {
                        doserch()
                    }
                });                              
                items.push({
                    type: 'serchbtn',
                    text: '�߼�����',
                    icon: '../../images/search.gif',
                    disable: true,
                    click: function () {
                        serchpanel();
                    }
                });
                $("#toolbar").ligerToolBar({
                    items: items
                });
                menu = $.ligerMenu({
                    width: 120, items: getMenuItems(data)
                });
                $("#keyword1").ligerTextBox({ width: 100, nullText: "����ؼ�������" })
                $("#maingrid4").ligerGetGridManager().onResize();
            });
            $.getJSON("../../data/toolbar.ashx?Action=GetSys&mid=" + mid2 + "&rnd=" + Math.random(), function (data, textStatus) {
                //alert(data);
                var items = [];
                var arr = data.Items;
                for (var i = 0; i < arr.length; i++) {
                    arr[i].icon = "../../" + arr[i].icon;
                    items.push(arr[i]);
                }
                items.push({ line: true });
                items.push({
                    type: 'textbox',
                    id: 'sectype1',
                    name: 'sectype1',
                    text: 'ɸѡ'
                });
                items.push({
                    type: 'textbox',
                    id: 'T_smart',
                    name: 'T_smart',
                    text: ''
                });
                items.push({
                    type: 'button',
                    text: '����',
                    icon: '../../images/search.gif',
                    disable: true,
                    click: function () {
                        doserch1()
                    }
                }); 
               
                $("#toolbar1").ligerToolBar({
                    items: items
                });
                menu1 = $.ligerMenu({
                    width: 120, items: getMenuItems(data)
                });
                $("#stype").ligerComboBox({
                    width: 100,
                    isMultiSelect: true,
                    url: "../../data/param_sysparam.ashx?Action=combo&parentid=1&rnd=" + Math.random()
                })
                $('#sectype').ligerComboBox({
                    width: 80,
                    isMultiSelect: true,
                    selectBoxWidth: 100,
                    selectBoxHeight: 160,
                    valueField: 'id',
                    textField: 'text',
                    treeLeafOnly: true,
                    tree: {
                        data: [
                            { text: '' },
                   { text: '��������' },
                   { text: '��Ҫ�˿�' },
                   { text: 'Ӧ��δ��' },
                   { text: '��Ч��ͼ' },
                   { text: '��Ч��ͼ' }
        

                        ],
                        checkbox: false
                    }
                });
                $('#thtype').ligerComboBox({
                    width: 80,
                    isMultiSelect: true,
                    selectBoxWidth: 120,
                    selectBoxHeight: 160,
                    valueField: 'id',
                    textField: 'text',
                    treeLeafOnly: true,
                    tree: {
                        data: [
                            { text: '' },
                   { text: 'δǩ��' },
                   { text: 'ǩ��δʩ��' },
                   { text: '����ʩ��' },
                   { text: 'ʩ�����' }


                        ],
                        checkbox: false
                    }
                });
                $("#sbq").ligerComboBox({
                    width: 100,
                    isMultiSelect: true,
                    url: "../../data/param_sysparam.ashx?Action=combo&parentid=18&rnd=" + Math.random()
                })

             var a=   $('#sectype1').ligerComboBox({
                    width: 180,
                    isMultiSelect: true,
                    selectBoxWidth: 200,
                    selectBoxHeight:100,
                    valueField: 'id',
                    textField: 'text',
                    treeLeafOnly: true,                 
                    tree: {
                        data: [
                            { id: '', text: 'ȫ��' },
                            { id:'kh', text: '�ͻ�' },
                            { id: 'sg',text: 'ʩ��' },
                            { id: 'wx',text: 'ά��' },
                            { id: 'sh', text: '�ۺ�' } 


                        ],
                        checkbox: false
                    }
                });
             a.selectValue("kh");
                $("#keyword1").ligerTextBox({ width: 100, nullText: "����ؼ�������" })
                $("#T_smart").ligerTextBox({ width: 100, nullText: "����ؼ�������������������" })
                $("#maingrid4").ligerGetGridManager().onResize();
                $("#maingrid5").ligerGetGridManager().onResize();

            });
        }
        function initSerchForm() {
           
            //var a = $('#T_City').ligerComboBox({ width: 96, emptyText: '���գ�' });
            //var b = $('#T_Provinces').ligerComboBox({
            //    width: 97,

            //    url: "../../data/Param_City.ashx?Action=combo1&rnd=" + Math.random(),
            //    onSelected: function (newvalue) {
            //        $.get("../../data/Param_City.ashx?Action=combo2&pid=" + newvalue + "&rnd=" + Math.random(), function (data, textStatus) {
            //            a.setData(eval(data));
            //        });
            //    }, emptyText: '���գ�'
            //});

            b = $('#T_Towns').ligerComboBox({
                width: 97,
                //url: "../../data/Param_City.ashx?Action=combo&rnd=" + Math.random(),
                onSelected: function (newvalue, newtext) {
                    if (!newvalue)
                        newvalue = -1;
                    $.get("../../data/Param_City.ashx?Action=combo2&pid=" + newvalue + "&rnd=" + Math.random(), function (data, textStatus) {
                        a.setData(eval(data));
                        a.selectValue(obj.Community_id);
                    });
                }, emptyText: '���գ�'
            });
            c = $('#T_City').ligerComboBox({
                width: 97,
                //url: "../../data/Param_City.ashx?Action=combo&rnd=" + Math.random(),
                onSelected: function (newvalue, newtext) {
                    if (!newvalue)
                        newvalue = -1;
                    $.get("../../data/Param_City.ashx?Action=combo2&pid=" + newvalue + "&rnd=" + Math.random(), function (data, textStatus) {
                        b.setData(eval(data));
                        b.selectValue(obj.Towns_id);
                    });
                }, emptyText: '���գ�'
            });
            d = $('#T_Provinces').ligerComboBox({
                width: 97,
                url: "../../data/Param_City.ashx?Action=combo1&rnd=" + Math.random(),
                onSelected: function (newvalue, newtext) {
                    if (!newvalue)
                        newvalue = -1;
                    $.get("../../data/Param_City.ashx?Action=combo2&pid=" + newvalue + "&rnd=" + Math.random(), function (data, textStatus) {
                        c.setData(eval(data));
                        c.selectValue(obj.City_id);
                    });
                }, emptyText: '���գ�'
            });
            $('#customertype').ligerComboBox({ width: 97, emptyText: '���գ�', url: "../../data/Param_SysParam.ashx?Action=combo&parentid=1&rnd=" + Math.random() });
            $('#industry').ligerComboBox({ width: 97, emptyText: '���գ�', url: "../../data/Param_SysParam.ashx?Action=combo&parentid=8&rnd=" + Math.random() });
            $('#WXZHT').ligerComboBox({ width: 97, emptyText: '���գ�', url: "../../data/Param_SysParam.ashx?Action=combo&parentid=15&rnd=" + Math.random() });
            $('#customerlevel').ligerComboBox({ width: 96, emptyText: '���գ�', url: "../../data/Param_SysParam.ashx?Action=combo&parentid=2&rnd=" + Math.random() });
            $('#cus_sourse').ligerComboBox({ width: 120, emptyText: '���գ�', url: "../../data/Param_SysParam.ashx?Action=combo&parentid=3&rnd=" + Math.random() });
           // $('#T_Community').ligerComboBox({ width: 120, emptyText: '���գ�', url: "../../data/Param_City.ashx?Action=getBuilding&rnd=" + Math.random() });
            var gCommunity = $('#T_Community').ligerComboBox({
                width: 120,
                //initValue: obj.Community_id,
                url: "../../data/Param_City.ashx?Action=getBuilding&rnd=" + Math.random(),
                onBeforeOpen: f_selectComm

            });
            var e = $('#employee').ligerComboBox({ width: 96, emptyText: '���գ�' });
            var f = $('#department').ligerComboBox({
                width: 97,
                selectBoxWidth: 240,
                selectBoxHeight: 200,
                valueField: 'id',
                textField: 'text',
                treeLeafOnly: false,
                tree: {
                    url: '../../data/hr_department.ashx?Action=tree&rnd=' + Math.random(),
                    idFieldName: 'id',
                    //parentIDFieldName: 'pid',
                    checkbox: false
                },
                onSelected: function (newvalue) {
                    $.get("../../data/hr_employee.ashx?Action=combo&did=" + newvalue + "&rnd=" + Math.random(), function (data, textStatus) {
                        e.setData(eval(data));
                    });
                }
            });

            var g = $('#employee_sg').ligerComboBox({ width: 96, emptyText: '���գ�' });
            var h = $('#department_sg').ligerComboBox({
                width: 97,
                selectBoxWidth: 240,
                selectBoxHeight: 200,
                valueField: 'id',
                textField: 'text',
                treeLeafOnly: false,
                tree: {
                    url: '../../data/hr_department.ashx?Action=tree&rnd=' + Math.random(),
                    idFieldName: 'id',
                    //parentIDFieldName: 'pid',
                    checkbox: false
                },
                onSelected: function (newvalue) {
                    $.get("../../data/hr_employee.ashx?Action=combo&did=" + newvalue + "&rnd=" + Math.random(), function (data, textStatus) {
                        g.setData(eval(data));
                    });
                }
            });

            var k = $('#employee_sj').ligerComboBox({ width: 96, emptyText: '���գ�' });
            var l = $('#department_sj').ligerComboBox({
                width: 97,
                selectBoxWidth: 240,
                selectBoxHeight: 200,
                valueField: 'id',
                textField: 'text',
                treeLeafOnly: false,
                tree: {
                    url: '../../data/hr_department.ashx?Action=tree&rnd=' + Math.random(),
                    idFieldName: 'id',
                    //parentIDFieldName: 'pid',
                    checkbox: false
                },
                onSelected: function (newvalue) {
                    $.get("../../data/hr_employee.ashx?Action=combo&did=" + newvalue + "&rnd=" + Math.random(), function (data, textStatus) {
                        k.setData(eval(data));
                    });
                }
            });
        }

        //¥��
        function f_selectComm() {
            top.$.ligerDialog.open({
                zindex: 9003,
                title: 'ѡ��¥��С��', width: 850, height: 400,

                //url: " hr/Getemp_Auth.aspx?auth=1", buttons: [
                url: "CRM/Customer/SelectCommunity.aspx", buttons: [
                    { text: 'ȷ��', onclick: f_selectCommOK },
                    { text: 'ȡ��', onclick: f_selectContactCancel }
                ]
            });
            return false;
        }
        function f_selectCommOK(item, dialog) {
            var data = dialog.frame.f_select();
            if (!data) {
                alert('��ѡ��¥��С��!');
                return;
            }
            filltempComm(data.id, data.Name);
            dialog.close();
        }
        function filltempComm(newvalue, text) {
            $('#T_Community_val').val(newvalue);
            $("#T_Community").val(text)
        }
        function serchpanel() {
            initSerchForm();
            if ($(".az").css("display") == "none") {
                $("#grid").css("margin-top", $(".az").height() + "px");
                $("#maingrid4").ligerGetGridManager().onResize();
                $("#maingrid5").ligerGetGridManager().onResize();
            }
            else {
                $("#grid").css("margin-top", "0px");
                $("#maingrid4").ligerGetGridManager().onResize();
                $("#maingrid5").ligerGetGridManager().onResize();
            }
            $("#company").focus();
        }
        $(document).keydown(function (e) {
            if (e.keyCode == 13 && e.target.applyligerui) {
                doserch();
            }
        });
        function doserch1()
        {
            var manager1 = $("#maingrid4").ligerGetGridManager();
            var row = manager1.getSelectedRow();
            if (row) {
                var sendtxt = "&Action=grid&srnd=" + Math.random();
                sendtxt = sendtxt + "&customer_id=" + row.id;
                var serchtxt = $("#toolbar1 :input").fieldSerialize() +   sendtxt;
                
                var manager5 = $("#maingrid5").ligerGetGridManager();
                manager5.GetDataByURL("../../data/CRM_Follow.ashx?" + serchtxt);
            }
            else {
                $.ligerDialog.warn('��ѡ��ͻ��У�');
            }
        }
        function doserch() {
           
            var sendtxt = "&Action=grid&type=0&rnd=" + Math.random();
            if (getparastr("type") == "TEMP")//�����ͻ�
                sendtxt = "&Action=grid&type=2&rnd=" + Math.random();
            var stxt = $("#form1 :input").fieldSerialize();

            var serchtxt = $("#serchform :input").fieldSerialize() + "&" + stxt + sendtxt;
             //alert(serchtxt);           
            var manager = $("#maingrid4").ligerGetGridManager();
            manager.GetDataByURL("../../data/crm_customer.ashx?" + serchtxt);

        }
        function doclear() {
            //var serchtxt = $("#serchform :input").reset();
            $("#serchform").each(function () {
                this.reset();
                $(".l-selected").removeClass("l-selected");
            });
        }

        var activeDialog = null;
        function f_openWindow(url, title, width, height) {
            var dialogOptions = {
                width: width, height: height, title: title, url: url, buttons: [
                        {
                            text: '����', onclick: function (item, dialog) {
                                f_save(item, dialog);
                            }
                        },
                        {
                            text: '�ر�', onclick: function (item, dialog) {
                                dialog.close();
                            }
                        }
                ], isResize: true, showToggle: true, timeParmName: 'a'
            };
            activeDialog = parent.jQuery.ligerDialog.open(dialogOptions);
        }
        var activeDialogS = null;
        function f_openWindow_ZZ(url, title, width, height) {
            var dialogOptions = {
                width: width, height: height, title: title, url: url, buttons: [
                        {
                            text: 'ת��', onclick: function (item, dialog) {
                                f_save_zz(item, dialog);
                            }
                        },
                        {
                            text: '�ر�', onclick: function (item, dialog) {
                                dialog.close();
                            }
                        }
                ], isResize: true, showToggle: true, timeParmName: 'a'
            };
            activeDialogS = parent.jQuery.ligerDialog.open(dialogOptions);
        }
        function toimport() {
            //var url = "../../file/ht.docx";

            //var $form = $('<form method="GET"></form>');
            //$form.attr('action', url);
            //$form.appendTo($('body'));
            //$form.submit();

            var dialogOptions = {
                width: 540, height: 295, title: '��ͬ����', url: 'crm/customer/customer_import_ht.aspx?type=' + getparastr("type"), buttons: [
                        {
                            text: '�ر�', onclick: function (item, dialog) {
                                dialog.close();
                            }
                        }
                ], isResize: true, timeParmName: 'a'
            };
            activeDialog = parent.jQuery.ligerDialog.open(dialogOptions);
        }
        //ת��
        function change()
        {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
           
                f_openWindow_ZZ('CRM/Customer/Customer_add.aspx?cid=' + row.id + "&type=" + getparastr("type"), "�޸Ŀͻ�", 660, 660);
            }
            else {
                $.ligerDialog.warn('��ѡ���У�');
            }
        }
        function add() {
            
            f_openWindow("CRM/Customer/Customer_add.aspx?type=" + getparastr("type"), "�����ͻ�", 660, 660);
        }

        function addContact() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                f_openWindow("CRM/Customer/Customer_Contact_add.aspx?Customer_id=" + row.id, "������ϵ��", 730, 450);
            }
            else {
                $.ligerDialog.warn('��ѡ��Ҫ���������ϵ�˵Ŀͻ��У�');
            }
        }

        function edit() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
               
                f_openWindow('CRM/Customer/Customer_add.aspx?cid=' + row.id + "&type=" + getparastr("type"), "�޸Ŀͻ�", 660, 660);
            }
            else {
                $.ligerDialog.warn('��ѡ���У�');
            }
        }
        function sedit() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
              
                    f_openWindow('CRM/Customer/Customer_add_GJXG.aspx?cid=' + row.id, "�ͻ��߼��޸�", 400, 400);
              
            }
            else {
                $.ligerDialog.warn('��ѡ���У�');
            }
        }

        var checkedID = [];
        function sendsms()
        { 
            var data = gg.getData();
            checkedID = [];
            for (var rowid in data) {
                addcheckedID(data[rowid]['tel']);
            }
            var rowid = checkedID.join(';');
            top.$.ligerDialog.open({
                zindex: 9003,
                title: '���Ͷ���', width: 850, height: 400,

                //url: " hr/Getemp_Auth.aspx?auth=1", buttons: [
                url: "CRM/Customer/SendSMS.aspx?tel=" + rowid, buttons: [
                    { text: '����', onclick: f_sendsmsOK },
                    { text: 'ȡ��', onclick: f_selectContactCancel }
                ]
            });
            return false;
            //alert(JSON.stringify(rowid));
        }
        function f_sendsmsOK(item, dialog) {
            dialog.frame.f_save();
             
        }
        function addcheckedID(tel) {
            if (findcheckedID(tel) == -1)
                checkedID.push(tel);
        }
        function findcheckedID(tel) {
            for (var i = 0; i < checkedID.length; i++) {
                if (checkedID[i] == tel) return i;
            }
            return -1;
        }
        //�ύʩ��
        function subconstruct() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
               
                if (row.Stage_icon != "��ǩ��")
                {
                    top.$.ligerDialog.error('��ǰ״̬��' + row.Stage_icon + '�������ύʩ����');
                    return;
                }
                if (row.Emp_sg == "" || row.Emp_sg == null) {
                    top.$.ligerDialog.error('ʩ��������Ϊ�գ�');
                    return;
                }
                $.ajax({
                    url: "../../data/CRM_CEStage.ashx", type: "POST",
                    data: { Action: "customersavecestage", id: row.id, rnd: Math.random() },
                    success: function (responseText) {
                        if (responseText == "true") {
                            top.$.ligerDialog.alert('�ύ�ɹ�������');
                            f_reload();
                            //f_followreload();
                        }
                        else if (responseText == "false") {
                            top.$.ligerDialog.error('�ύʧ�ܣ�');
                        }
                        
                        else if (responseText == "false:exist") {
                            top.$.ligerDialog.error('�ύʧ�ܣ��Ѿ�����');
                        }
                        else if (responseText=="false:site is not 1"){
                            top.$.ligerDialog.error('�˿ͻ�δǩ�����ύʧ�ܣ�');
                        }

                    },
                    error: function () {
                        top.$.ligerDialog.error('�ύʧ�ܣ�');
                    }
                });
            }
            else {
                $.ligerDialog.warn('��ѡ���У�');
            }
        }

        var activeDialog = null;
        function f_openWindow_view(url, title, width, height) {
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
        function viewkjl(url, newname) {
            window.open(url + "&width=" + screen.width +
                                "&height=" + (screen.height - 70), newname,
                                "top=0,left=0,toolbar=no, menubar=no, scrollbars=yes,resizable=no,location=no,status=no,width=" +
                                screen.width + ",height=" +
                                (screen.height - 70));
        }

        function editt(){
         
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
               
                viewkjl('../../CRM/ConsExam/kjl_index.aspx?cid=' + row.id
                    + '&name=' + encodeURI('��' + row.Customer + '��' + row.address),
                    "�༭Ч��ͼ");
            }
            else {
                $.ligerDialog.warn('��ѡ���У�');
            }
           
        }

        //function viewdy() {
        //    //url, newname
        //  var manager = $("#maingrid4").ligerGetGridManager();
        //    var row = manager.getSelectedRow();
        //    if (row) {
        //        $.ajax({
        //            url: "../../Data/website.ashx", type: "GET",
        //            data: { Action: "getqjapi", tel: row.tel, rnd: Math.random() },
        //            //data: { tel: row.tel},
        //            success: function (result) {

        //                var obj = eval("(" + result + ")");


        //                if (obj.status == 1) {
        //                    $.each(obj.data, function (i, data) {
        //                        if (data.project.length > 0) {
        //                            $.each(data.project, function (i, r) {
        //                                window.open(r["thumb_path"] + "?1=1&width=" + screen.width +
        //                                  "&height=" + (screen.height - 70), r["name"],
        //                                    "top=0,left=0,toolbar=no, menubar=no, scrollbars=yes,resizable=no,location=no,status=no,width=" +
        //                                    screen.width + ",height=" +
        //                                    (screen.height - 70));  
        //                                //alert(r["name"]);
        //                            })
        //                        } else {
        //                            alert("û�л�ȡ����Ч��ȫ��ͼ��");
        //                        }
        //                   });
        //                } else {
        //                    alert("��ȡʧ�ܣ���");
        //                }
                        
                         
        //            },
        //            error: function () {

        //                alert("��ȡʧ��2��");
                    
        //            }
        //        });
        //    }
            
        //}
        function viewdy() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
               // viewkjl('../../CRM/ConsExam/kjl_index.aspx?cid=' + row.id+ '&name=' + encodeURI("��" + row.Customer + "��" + row.address), "��" + row.address + "��");
                f_openWindow_view('CRM/Customer/Customer_DynamicGraphics.aspx?cid=' + row.id + '&name=' + encodeURI(row.Customer)
                        + '&tel=' + row.tel
                        + '&sjs=' + encodeURI(row.Emp_sj), "��"+row.address+"��ȫ��ͼ��", 660, 550);
            }
            else {
                $.ligerDialog.warn('��ѡ���У�');
            }
        }
        //�ύǩ��
        function subok() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                //if (row.Emp_sg == "" || row.Emp_sg == null) {
                //    top.$.ligerDialog.error('ʩ��������Ϊ�գ�');
                //    return;
                //}
                $.ajax({
                    url: "../../data/CRM_Customer.ashx?t_cus="+row.address, type: "POST",
                    data: { Action: "subok", customerId: row.id, rnd: Math.random() },
                    success: function (responseText) {
                        if (responseText == "true") {
                            top.$.ligerDialog.alert('�ύǩ���ɹ���');
                            f_reload();
                            //f_followreload();
                        }
                        else if (responseText == "false") {
                            top.$.ligerDialog.error('����ʧ�ܣ�����ϵϵͳ����Ա��');
                        }
                    },
                    error: function () {
                        top.$.ligerDialog.error('�ύǩ��ʧ�ܣ�');
                    }
                });
            }
            else {
                $.ligerDialog.warn('��ѡ���У�');
            }
        }

        function addys() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                f_openWindow('CRM/sale/order_add_khjdgl.aspx?customerid=' + row.id, "����Ӧ��", 650, 400);
            }
            else {
                $.ligerDialog.warn('��ѡ���У�');
            }
        }

        function addDj() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                f_openWindow("CRM/finance/Receive_add_khjdgl.aspx?customerid=" + row.id + "&sklb=addDj", "�ն���", 800, 680); //sklb�տ����
            }
            else {
                $.ligerDialog.warn('��ѡ�񶩵���');
            }
        }
        function minusDj() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                f_openWindow("CRM/finance/Receive_add_khjdgl.aspx?customerid=" + row.id + "&sklb=minusDj", "�˶���", 800, 680);
            }
            else {
                $.ligerDialog.warn('��ѡ�񶩵���');
            }
        }
        function addZxk() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                f_openWindow("CRM/finance/Receive_add_khjdgl.aspx?customerid=" + row.id + "&sklb=addZxk", "��װ�޿�", 800, 680);
            }
            else {
                $.ligerDialog.warn('��ѡ�񶩵���');
            }
        }
        function minusZxk() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                f_openWindow("CRM/finance/Receive_add_khjdgl.aspx?customerid=" + row.id + "&sklb=minusZxk", "��װ�޿�", 800, 680);
            }
            else {
                $.ligerDialog.warn('��ѡ�񶩵���');
            }
        }
        function addQt() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                f_openWindow("CRM/finance/Receive_add_khjdgl.aspx?customerid=" + row.id + "&sklb=addQt", "����������", 800, 680);
            }
            else {
                $.ligerDialog.warn('��ѡ�񶩵���');
            }
        }
        function minusQt() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                f_openWindow("CRM/finance/Receive_add_khjdgl.aspx?customerid=" + row.id + "&sklb=minusQt", "����������", 800, 680);
            }
            else {
                $.ligerDialog.warn('��ѡ�񶩵���');
            }
        }

        function f_selectContactCancel(item, dialog) {
            dialog.close();
            //fload();
        }
        function del() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                $.ligerDialog.confirm("ȷ����������", function (yes) {
                    if (yes) {
                        $.ajax({
                            url: "../../data/CRM_Customer.ashx", type: "POST",
                            data: { Action: "AdvanceDelete", id: row.id, rnd: Math.random() },
                            success: function (responseText) {
                                if (responseText == "true") {
                                    f_reload();
                                    f_followreload();
                                }
                                else if (responseText == "delfalse") {
                                    top.$.ligerDialog.error('Ȩ�޲�����ɾ��ʧ�ܣ�');
                                }
                                else if (responseText == "false") {
                                    top.$.ligerDialog.error('δ֪����ɾ��ʧ�ܣ�');
                                }
                                else {
                                    top.$.ligerDialog.warn('�˿ͻ��º��� ' + responseText + '��ɾ��ʧ�ܣ������Ƚ���Щ����ɾ����');
                                }

                            },
                            error: function () {
                                top.$.ligerDialog.error('ɾ��ʧ�ܣ�');
                            }
                        });
                    }
                });
            }
            else {
                $.ligerDialog.warn("��ѡ��ͻ�");
            }
        }
        function toexport() {
            var sendtxt = "&Action=ToExcel&rnd=" + Math.random();
            var serchtxt = $("#serchform :input").fieldSerialize() + sendtxt;
            var url = "../../data/crm_customer.ashx?" + serchtxt;

            window.open(url);
        }
        function f_save(item, dialog) {
            var issave = dialog.frame.f_save();
        
            if (issave) {
                dialog.close();

                $.ajax({
                    url: "../../data/CRM_Customer.ashx", type: "POST",
                    data: issave,
                    beforesend: function () {
                        top.$.ligerDialog.waitting('���ݱ�����,���Ժ�...');
                    },
                    success: function (responseText) {
                        //alert(222)
                        f_followreload();//ˢ���°벿��
                        f_reload();//ˢ���ϰ벿��
                        top.flushiframegrid("tabid5");
                    },
                    error: function () {
                        top.$.ligerDialog.error('����ʧ�ܣ�');
                    },
                    complete: function () {
                        top.$.ligerDialog.closeWaitting();
                    }
                });

            }
        }
        function f_save_zz(item, dialog) {
            var issave = dialog.frame.f_save_zz();

            if (issave) {
                dialog.close();

                $.ajax({
                    url: "../../data/CRM_Customer.ashx", type: "POST",
                    data: issave,
                    beforesend: function () {
                        top.$.ligerDialog.waitting('���ݱ�����,���Ժ�...');
                    },
                    success: function (responseText) {

                        f_reload();
                        top.flushiframegrid("tabid5");
                    },
                    error: function () {
                        top.$.ligerDialog.error('����ʧ�ܣ�');
                    },
                    complete: function () {
                        top.$.ligerDialog.closeWaitting();
                    }
                });

            }
        }
        function f_reload() {
            var manager = $("#maingrid4").ligerGetGridManager();
            manager.loadData(true);
            //alert(1)
        };

        //follow
        function follow_openWindow(url, title, width, height) {
            var dialogOptions = {
                width: width, height: height, title: title, url: url, buttons: [
                        {
                            text: '����', onclick: function (item, dialog) {
                                f_savefollow(item, dialog);
                            }
                        },
                        {
                            text: '�ر�', onclick: function (item, dialog) {
                                dialog.close();
                            }
                        }
                ], isResize: true, showToggle: true, timeParmName: 'b'
            };
            activeDialog1 = top.jQuery.ligerDialog.open(dialogOptions);
        }
        function addfollow() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                follow_openWindow("CRM/Customer/Customer_follow_add.aspx?cid=" + row.id, "��������", 530, 400);
            } else {
                $.ligerDialog.warn('��ѡ��ͻ���');
            }
        }
        function editfollow() {
            var manager = $("#maingrid5").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                follow_openWindow('CRM/Customer/Customer_follow_add.aspx?fid=' + row.id + "&cid=" + row.Customer_id, "�޸ĸ���", 530, 400);
            } else {
                $.ligerDialog.warn('��ѡ�������');
            }
        }
        function delfollow() {
            var manager = $("#maingrid5").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                $.ligerDialog.confirm("����ɾ���޷��ָ���ȷ��ɾ����", function (yes) {
                    if (yes) {
                        $.ajax({
                            url: "../../data/CRM_Follow.ashx", type: "POST",
                            data: { Action: "del", id: row.id, rnd: Math.random() },
                            success: function (responseText) {
                                if (responseText == "true") {
                                    f_followreload();
                                    f_reload();
                                }
                                else {
                                    top.$.ligerDialog.error('ɾ��ʧ�ܣ�');
                                }

                            },
                            error: function () {
                                top.$.ligerDialog.error('ɾ��ʧ�ܣ�');
                            }
                        });
                    }
                })
            }
            else {
                $.ligerDialog.warn("��ѡ�����");
            }
        }
        function f_savefollow(item, dialog) {
            var issave = dialog.frame.f_save();
            if (issave) {
                dialog.close();
                $.ligerDialog.waitting('���ݱ�����,���Ժ�...');
                $.ajax({
                    url: "../../data/CRM_Follow.ashx", type: "POST",
                    data: issave,
                    success: function (responseText) {
                        $.ligerDialog.closeWaitting();
                        f_followreload();
                        f_reload();
                        top.flushiframegrid("tabid6");
                    },
                    error: function () {
                        $.ligerDialog.closeWaitting();
                        $.ligerDialog.error('����ʧ�ܣ�');
                    }
                });

            }
        }
        //����
        var activeDialog_repair = null;
        function f_openWindow_repair(url, title, width, height) {
            var dialogOptions = {
                width: width, height: height, title: title, url: url, buttons: [
                    {
                        text: '����', onclick: function (item, dialog) {
                            f_save_repair(item, dialog);
                        }
                    },
                    {
                        text: '�ر�', onclick: function (item, dialog) {
                            dialog.close();
                        }
                    }
                ], isResize: true, showToggle: true, timeParmName: 'a'
            };

            activeDialog_repair = parent.jQuery.ligerDialog.open(dialogOptions);

        }
        function repair() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                f_openWindow_repair("CRM/Repair/Repair_add.aspx?tel=" + row.tel, "���޵Ǽ�", 850, 590);

            } else {
                $.ligerDialog.warn('��ѡ��ͻ���');
            }
        }
        function f_save_repair(item, dialog) {
            var issave = dialog.frame.f_save();
            if (issave) {
                dialog.close();

                $.ajax({
                    url: "../../CRM/Repair/Repair_Add.aspx", type: "POST",
                    data: issave,
                    beforesend: function () {
                        top.$.ligerDialog.waitting('���ݱ�����,���Ժ�...');
                    },
                    success: function (data) {
                        f_reload();
                        //f_followreload();
                        if (data == "")
                            top.$.ligerDialog.success('�����ɹ���');
                        else
                            top.$.ligerDialog.error('����ʧ�ܣ�������Ϣ��' + data);
                    },
                    error: function (ex) {
                        top.$.ligerDialog.error('����ʧ�ܣ�������Ϣ��' + ex.responseText);
                    },
                    complete: function () {
                        top.$.ligerDialog.closeWaitting();
                    }
                });
            }
        }

        function f_followreload() {
            var manager = $("#maingrid5").ligerGetGridManager();
            manager.loadData(true);
            //top.flushiframegrid("tabid6");
        };
    </script>
    <style type="text/css">
        .l-treeleve1 {
            background: yellow;
        }

        .l-treeleve2 {
            background: yellow;
        }

        .l-treeleve3 {
            background: #eee;
        }
    </style>
</head>
<body>
    <form id="form1" onsubmit="return false">
        <div id="toolbar"></div>

        <div id="grid">
            <div id="maingrid4" style="margin: -1px; min-width: 800px;"></div>
            <div id="toolbar1"></div>
            <div id="Div1" style="position: relative;">
                <div id="maingrid5" style="margin: -1px -1px;"></div>
            </div>
        </div>


    </form>
    <div class="az">
        <form id='serchform'>
            <table style='width: 960px' class="bodytable1">
                <tr>
                    <td>
                        <div style='width: 60px; text-align: right; float: right'>�ͻ�������</div>
                    </td>
                    <td>
                        <input type='text' id='company' name='company' ltype='text' ligerui='{width:120}' /></td>

                    <td>
                        <div style='width: 60px; text-align: right; float: right'>�ͻ����ͣ�</div>
                    </td>
                    <td>
                        <div style='width: 100px; float: left'>
                            <input type='text' id='customertype' name='customertype' />
                        </div>
                        <div style='width: 98px; float: left'>
                            <input type='text' id='customerlevel' name='customerlevel' />
                        </div>
                    </td>
                    <td>
                        <div style='width: 60px; text-align: right; float: right'>¼��ʱ�䣺</div>
                    </td>
                    <td>
                        <div style='width: 100px; float: left'>
                            <input type='text' id='startdate' name='startdate' ltype='date' ligerui='{width:97}' />
                        </div>
                        <div style='width: 98px; float: left'>
                            <input type='text' id='enddate' name='enddate' ltype='date' ligerui='{width:96}' />
                        </div>
                    </td>
                    <td>
                        <input id='keyword' name="keyword" type='text' ltype='text' ligerui='{width:196, nullText: "����ؼ���������ַ����������ע"}' />
                    </td>
                </tr>
                <tr>
                    <td>
                        <div style='width: 60px; text-align: right; float: right'>����¥�̣�</div>
                    </td>
                    <td>
                        <input id='T_Community' name="T_Community" type='text' /></td>

                    <td>
                        <div style='width: 60px; text-align: right; float: right'>����ʡ�У�</div>
                    </td>
                    <td>
                        <div style='width: 100px; float: left'>
                            <input type='text' id='T_Provinces' name='T_Provinces' />
                        </div>
                        <div style='width: 98px; float: left'>
                            <input type='text' id='T_City' name='T_City' />
                        </div>
                    </td>
                    <td>
                        <div style='width: 60px; text-align: right; float: right'>��������</div>
                    </td>
                    <td>
                        <div style='width: 100px; float: left'>
                            <input type='text' id='startfollow' name='startfollow' ltype='date' ligerui='{width:97}' />
                        </div>
                        <div style='width: 98px; float: left'>
                            <input type='text' id='endfollow' name='endfollow' ltype='date' ligerui='{width:96}' />
                        </div>
                    </td>
                    
                                        <td>
                       <input id='emp_hh' name="emp_hh" type='text' ltype='text' ligerui='{width:196}' />
                    </td>

                </tr>
                <tr>
                    <td>
                        <div style='width: 60px; text-align: right; float: right'>�绰��</div>
                    </td>
                    <td>
                        <input type='text' id='tel' name='tel' ltype='text' ligerui='{width:120}' />
                    </td>
                    <td>
                        <div style='width: 60px; text-align: right; float: right'>��������</div>
                    </td>
                    <td>
                        <div style='width: 100px; float: left'>
                            <input type='text' id='T_Towns' name='T_Towns' />
                        </div>

                    </td>

                    <td>
                        <div style='width: 60px; text-align: right; float: right'>ҵ��Ա��</div>
                    </td>
                    <td>
                        <div style='width: 100px; float: left'>
                            <input type='text' id='department' name='department' />
                        </div>
                        <div style='width: 98px; float: left'>
                            <input type='text' id='employee' name='employee' />
                        </div>
                    </td>
                    <td>

                        <input id='Button2' type='button' value='����' style='width: 80px; height: 24px'
                            onclick="doclear()" />
                        <input id='Button1' type='button' value='����' style='width: 80px; height: 24px' onclick="doserch()" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <div style='width: 60px; text-align: right; float: right'>�ͻ���Դ��</div>
                    </td>
                    <td>
                        <input type='text' id='cus_sourse' name='cus_sourse' />
                    </td>
                    <td>
                        <div style='width: 60px; text-align: right; float: right'>ʩ������</div>
                    </td>
                    <td>
                        <div style='width: 100px; float: left'>
                            <input type='text' id='department_sg' name='department_sg' />
                        </div>
                        <div style='width: 98px; float: left'>
                            <input type='text' id='employee_sg' name='employee_sg' />
                        </div>
                    </td>

                    <td>
                        <div style='width: 60px; text-align: right; float: right'>���ʦ��</div>
                    </td>
                    <td>
                        <div style='width: 100px; float: left'>
                            <input type='text' id='department_sj' name='department_sj' />
                        </div>
                        <div style='width: 98px; float: left'>
                            <input type='text' id='employee_sj' name='employee_sj' />
                        </div>
                    </td>
                </tr>
                                <tr>
                    <td>
                        <div style='width: 60px; text-align: right; float: right'>΢��״̬��</div>
                    </td>
                    <td>
                        <input type='text' id='WXZHT' name='WXZHT' /> 
                    </td>
                                    <td>
                        <div style='width: 60px; text-align: right; float: right'>��ͼ״̬��</div>
                    </td>
                    <td>
                             <input id="t_mapstasus" name="t_mapstasus" type="text" ltype="select" ligerui="{width:196,data:[{id:'0',text:'ȫ��'},{id:'1',text:'�ѱ��ͼ'},{id:'2',text:'δ���ͼ'}]}"  /></td>
           
                     
                 
                    

                    <td>
                        <div style='width: 60px; text-align: right; float: right'>�ͻ�״̬</div>
                    </td>
                    <td>
                        <div style='width: 100px; float: left'>
                            <input type='text' id='industry' name='industry' />
                        </div>
                        <div style='width: 98px; float: left'>
                            ������ʱ
                         <input type="checkbox" name="ckisgd" id="ckisgd"  />  
                        </div>
                    </td>
                </tr>
            </table>
        </form>
    </div>

    <form id='toexcel'></form>
</body>
</html>
