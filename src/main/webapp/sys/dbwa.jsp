<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="oracle.sql.*" %>
<%@ page import="oracle.jdbc.driver.*" %>
<%@ page import="javax.servlet.jsp.JspWriter" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>

<%
/*
 * DB Web Admin
 *
 * JSP Version source file
 *
 * The purpose of DB Web Admin is to provide System Administrators and Database Administrators a way to quickly monitor Current Users, Processes, and Locks in the System.
 * DB Web Admin is implemented in PL/SQL and is easy to install on an Oracle Database Server.
 * DB Web Admin also works well with Oracle Applications showing all logged in Application Users and their respective processes.
 * DB Web Admin also allows users to have the Database execute a free-form query.
 * Finally, DB Web Admin allows users to kill sessions that may be causing locks in the system.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 * See file named "gpl.txt" included with source code or
 * visit http://www.gnu.org/copyleft/gpl.txt on the internet.
 *
 * DB Web Admin is Free and Distributable under the GNU General Public License (GPL). Please See the gpl.txt file for more information.
 */

//************************************************************************************
//* Begin Variable and Function Definition/Initialization
//************************************************************************************
%>

<%! Connection conn; %>
<%! Statement stmt; %>
<%! ResultSet rset; %>
<%! String stQueryLock; %>
<%! String stUserProcesses; %>
<%! String stUsers; %>
<%! String stProcesses; %>
<%! String stIsAlert = new String(""); %>
<%! String stIsKill = new String(""); %>
<%! String stAlertSession = new String(""); %>
<%! String stAlertQuery = new String(""); %>
<%! String stIsSQLQuery = new String(""); %>
<%! int iCount; %>

<% 
	// Establish Communication between Oracle and JDBC by Registering the Oracle Driver
	DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver()); 

	// Begin Connection to Oracle Database

	// Sample connection using OCI Driver, here oracle.world is the TNSNAMES entry in tnsnames.ora file, apps is the username, and passwd is the password.
	//conn = DriverManager.getConnection("jdbc:oracle:oci8:@oracle.world", "apps", "passwd");

	// Sample connection using OCI Thin Driver, explicitly defining the host name, the TCP/IP port number, and the SID of the Database to connect to
	//		in this example, training is the host, 1521 is the TCP/IP listener port, the SID is oracle, apps is the username, and passwd is the password.
	//conn = DriverManager.getConnection("jdbc:oracle:thin:@training:1521:oracle", "apps", "passwd");

	// Sample connection using OCI Thin Driver, specifying the Net8 keyword-value pair list  
	//		in this example, training is the host, 1521 is the TCP/IP listener port, the SID is oracle, apps is the username, and passwd is the password.
	//		(Note: you can also use the JDBC OCI Driver using the Net8 keyword-value pair list, just specify oci8 instead of thin below)
	//conn = DriverManager.getConnection("jdbc:oracle:thin:@(DESCRIPTION=(ADDRESS=(PROTOCOL=tcp)(HOST=training)(PORT=1521))(CONNECT_DATA=(SID=oracle)))", "apps", "passwd");

	//Replace Connection Info Here:
	conn = DriverManager.getConnection("jdbc:oracle:thin:@(DESCRIPTION=(ADDRESS=(PROTOCOL=tcp)(HOST=192.168.5.133)(PORT=1521))(CONNECT_DATA=(SID=orcl)))", "system", "oracle");
	
	//javax.sql.DataSource ds = (javax.sql.DataSource)net.sf.husky.utils.SpringUtils.getBean("dataSource");
	//conn = ds.getConnection();
	//
%>
<% stmt = conn.createStatement(); %>
<% stQueryLock = "select sid,v$session.serial# serial,pid,spid,os_user_name osuser,oracle_username orauser,machine,object_name, " +    "decode(locked_mode,0,'None',1,'Null',2,'Row-S',3,'Row-X',4,'Share',5,'S/Row-X',6,'Exclusive',to_char(locked_mode)) lockmode, decode(lockwait,NULL,'Holder',lockwait,'Waiter') lockwait, " +
"dba_dml_locks.blocking_others, last_call_et " +
"from v$locked_object, sys.dba_objects, v$process, v$session, sys.dba_dml_locks " +
"where dba_objects.object_id = v$locked_object.object_id and v$process.addr = v$session.paddr and v$locked_object.session_id = v$session.sid " +
"and v$locked_object.session_id = dba_dml_locks.session_id and dba_dml_locks.name = dba_objects.object_name " +
"order by lockwait, osuser, sid"; %>
<% stUserProcesses = "select a.osuser, d.user_name username, a.sid, a.serial#, c.pid ,c.spid shadow, a.process, a.program, a.terminal, d.time, a.status, a.last_call_et, a.module, a.action, " +
"decode(b.event,'SQL*Net message from client',null,b.event) event " +
"from v$session a, v$session_wait b, v$process c, apps.fnd_signon_audit_view d " +
"where a.username is not null " +
"and a.sid = b.sid " +
"and a.paddr = c.addr " +
"and c.pid = d.pid (+) " +
"order by osuser, user_name"; %>
<% stUsers = "select fu.user_name, count(*) count, p.spid shadow, s.process, s.program, to_char(fl.start_time, 'dd-mon hh24:mi') st, fl.end_time " +
"from apps.fnd_user fu, apps.fnd_logins fl, v$process p,  v$session s " +
"where s.paddr = p.addr and s.process = fl.spid and fl.user_id = fu.user_id " +
"group by fu.user_name, p.spid, s.process, s.program, fl.start_time, fl.end_time " +
"order by fu.user_name, to_char(fl.start_time, 'dd-MON hh24:mi')"; %>
<% stProcesses = "select s.sid, s.serial#, p.pid, s.osuser, s.username, s.process, p.spid shadow, s.terminal, s.program " +
"from sys.v_$process p, sys.v_$session s " +
"where rawtohex(s.paddr) = rawtohex(p.addr) " +
"order by s.username, s.osuser, s.program, s.process"; %>

<%! 
private void killSession(String p_kill_sid, String p_kill_serial, Connection conn, JspWriter out) throws SQLException, IOException
{
	try{
	Statement stmt;
	String stKillSessionQuery;
	stKillSessionQuery = "ALTER SYSTEM KILL SESSION '" + p_kill_sid + "," + p_kill_serial + "'";
	stmt = conn.createStatement();
	stmt.executeQuery(stKillSessionQuery);
    out.println("<!--" + stKillSessionQuery + "-->");
	
	stmt.close();
		} catch (Exception ekill) 
	{
		out.println("Error At killSession");
		out.println(ekill.toString());
	}
}

private void executeSQLQuery(String stQuery, Connection conn, JspWriter out) throws SQLException, IOException
{
	
	ResultSet rset;
	Statement stmt;
	ResultSetMetaData rsmd;
	int numberOfColumns = 0;
	int iCurrRow = 0;
	String stSeparator;
	stmt = conn.createStatement();
	rset = stmt.executeQuery(stQuery);
	rsmd = rset.getMetaData();
	try{
    numberOfColumns = rsmd.getColumnCount();
	out.println("<table cellspacing=\"1\" cellpadding=\"1\"><tr class=\"table-header\">");
	for(int i = 1; i <= numberOfColumns; i++)
	{
		out.println("<td><nobr><tt>" + rsmd.getColumnLabel(i) + "</tt></nobr></td>");
	}
	out.println("</tr>");

	iCurrRow = 0;
	while (rset.next()) {
		stSeparator = "table-separator-odd";
		if(iCurrRow % 2 == 0)
			stSeparator = "table-separator-even";
		out.println("<tr class=\"" + stSeparator + "\">");
		for(int i = 1; i <= numberOfColumns; i++)
		{
			out.println("<td><nobr><tt>" + rset.getString(i) + "</tt></nobr></td>");
		}
		out.println("</tr>");
		iCurrRow++;
	}
	out.println("<tr class=\"table-header\"><td colspan=\"" + numberOfColumns + "\"><nobr><tt>" + iCurrRow + " Rows Returned</tt></nobr></td></tr>");
	out.println("</table>");
	out.println("<a href=\"dbwa.jsp\">Return to DB Web Admin Main Page</a>");
	} catch (Exception esql) 
		{
			out.println("Error At executeSQLQuery");
			out.println(esql.toString());
		}
}

private void printHeader(JspWriter out) throws IOException
{
	out.println("<html>");
	out.println("<head>");
	out.println("<title>DB Web Admin</title>");
	out.println("<link rel=\"stylesheet\" type=\"text/css\" href=\"./dbwa.css\" title=\"Default\">");
	out.println("<script LANGUAGE=\"JavaScript\">");
	out.println("<!-- Begin");
	out.println("function kill_session(kill_sid, kill_serial){");
		out.println("var kill = confirm(\"Are you sure you want to kill this session?\\nSession ID: \" + kill_sid + \", Session Serial Number:\" + kill_serial);");
		out.println("if(kill == true)");
		out.println("{");
			out.println("document.MAIN_LOCK_KILLER.p_kill_sid.value=kill_sid;document.MAIN_LOCK_KILLER.p_kill_serial.value=kill_serial;document.MAIN_LOCK_KILLER.submit();");
			out.println("return true;");
		out.println("}");
		out.println("else");
		out.println("{");
			out.println("return false;");
		out.println("}");
	out.println("}");
	out.println("function help_window()");
	out.println("{");
		out.println("var help_win = window.open('/OA_DOC/US/dbwa_help.htm', \"help_win\", \"resizable=yes,scrollbars=yes,toolbar=yes,width=450,height=250\");");
	out.println("}");
	out.println("-->");
	out.println("</SCRIPT>");
	out.println("</head>");
	out.println("<body>");
	out.println("<font face=\"Verdana\" size=\"6\" color=\"#808080\">");
	out.println("Welcome to DB Web Admin");
	out.println("</font>");

}

private void printQueryEnter(JspWriter out) throws IOException
{
	out.println("<hr>");
	out.println("<FONT face=\"Verdana\" size=\"4\" color=\"#008080\">");
	out.println("Execute SQL Query Statement:");
	out.println("</FONT>");
	out.println("<FORM name=\"query_enter\" id=\"query_enter\" method=\"POST\" action=\"\">");
	out.println("<TABLE cellspacing=\"1\" cellpadding=\"1\"><TR>");
	out.println("<TD><textarea rows=\"10\" cols=\"64\" name=\"sql_query\"></textarea></td>");
	out.println("</TR><TR><TD><input type=\"hidden\" name=\"execute_query\" value=\"true\"><input type=\"submit\" name=\"execute\" value=\"Execute Query\"></TD></TR>");
	out.println("</FORM>");
	out.println("</TABLE>");
}

private void printLocks(JspWriter out,String stQueryLock) throws SQLException, IOException
{
	int iCount;

	out.println("<hr>");
	out.println("<FONT face=\"Verdana\" size=\"4\" color=\"#008080\">");
	out.println("Current System Locks:");
	out.println("</FONT>");

	out.println("<TABLE cellspacing=\"1\" cellpadding=\"1\">");
	out.println("<TR class=\"table-header\">");
	out.println("<TD><NOBR><tt>&nbsp;</tt></NOBR></TD><TD><NOBR><tt>&nbsp;</tt></NOBR></TD><TD><NOBR><tt>sid</tt></NOBR></TD><TD><NOBR><tt>Serial #</tt></NOBR></TD>");
	out.println("<TD><NOBR><tt>pid</tt></NOBR></TD><TD><NOBR><tt>spid</tt></NOBR></TD><TD><NOBR><tt>OS User</tt></NOBR></TD><TD><NOBR><tt>Oracle User</tt></NOBR></TD>");
	out.println("<TD><NOBR><tt>Machine</tt></NOBR></TD><TD><NOBR><tt>Object Name</tt></NOBR></TD><td><NOBR><tt>Lock Mode</tt></NOBR></td><td><NOBR><tt>Lock Wait</tt></NOBR></td>");
	out.println("<TD><NOBR><tt>Blocking Others?</tt></NOBR></td><TD><NOBR><tt>Idle(sec)</tt></NOBR></td>");
	out.println("</TR>");
	try{
		rset = stmt.executeQuery(stQueryLock); 

	iCount = 0;
	while (rset.next()) {
		if (iCount%2 == 0) {
			out.println("<TR class=\"table-separator-even\">");
		} 
		else {
			out.println("<TR class=\"table-separator-odd\">");
		}
	out.println("<td><input type=\"button\" value=\"Cursor\" name=\"c_button\" onClick=\"javascript:document.MAIN_CURSOR_ALERT.p_cursor_alert.value=" + rset.getInt(1) + ";document.MAIN_CURSOR_ALERT.submit();\"></td>");
	out.println("<td><input type=\"button\" value=\"Kill Session\" name=\"p_button\" onClick=\"javascript:kill_session(" + rset.getInt("sid") + "," + rset.getInt("serial") + ");\"></td>");
	out.println("<TD><NOBR><tt>" + rset.getInt("sid") + "</tt></NOBR></td><td><NOBR><tt>" + rset.getInt("serial") + "</tt></NOBR></td><td><NOBR><tt>" + rset.getInt("pid") + "</tt></NOBR></td>");
	out.println("<td><NOBR><tt>" + rset.getString("spid") + "</tt></NOBR></td><td><NOBR><tt>" + rset.getString("osuser") + "</tt></NOBR></td><td><NOBR><tt>" + rset.getString("orauser") + "</tt></NOBR></td>");
	out.println("<td><NOBR><tt>" + rset.getString("machine") + "</tt></NOBR></td><td><NOBR><tt>" + rset.getString("object_name") + "</tt></NOBR></td><td><NOBR><tt>" + rset.getString("lockmode") + "</tt></NOBR></td>");
	out.println("<td><NOBR><tt>" + rset.getString("lockwait") + "</tt></NOBR></td><td><NOBR><tt>" + rset.getString("blocking_others") + "</tt></NOBR></td><td><NOBR><tt>" + rset.getInt("last_call_et") + "</tt></NOBR></td>");
		out.println("</TR>");
		iCount++;
		}//end while (rset.next()) 
	} catch (Exception e1) 
		{
			out.println("Error At Current System Locks");
			out.println(e1.toString());
		}
	if (rset != null) rset.close();
	out.println("</TABLE>");
}

private void printUserProcesses(JspWriter out, String stUserProcesses) throws SQLException, IOException
{
	int iCount;
	out.println("<hr>");
	out.println("<FONT face=\"Verdana\" size=\"4\" color=\"#008080\">");
	out.println("Current System User and Process Information:");
	out.println("</FONT>");

	out.println("<TABLE cellspacing=\"1\" cellpadding=\"1\">");
	out.println("<TR class=\"table-header\">");
	out.println("<TD><NOBR><tt>&nbsp;</tt></NOBR></TD><TD><NOBR><tt>&nbsp;</tt></NOBR></TD><TD><NOBR><tt>O/S User</tt></NOBR></TD><TD><NOBR><tt>User Name</tt></NOBR></TD>");
	out.println("<TD><NOBR><tt>Session ID</tt></NOBR></TD><TD><NOBR><tt>Serial #</tt></NOBR></TD><TD><NOBR><tt>Process ID</tt></NOBR></TD><TD><NOBR><tt>Shadow</tt></NOBR></TD>");
	out.println("<TD><NOBR><tt>Process</tt></NOBR></TD><TD><NOBR><tt>Program</tt></NOBR></TD><td><NOBR><tt>Terminal</tt></NOBR></td><td><NOBR><tt>Time</tt></NOBR></td>");
	out.println("<TD><NOBR><tt>Status</tt></NOBR></td><TD><NOBR><tt>Idle(sec)</tt></NOBR></td><td><NOBR><tt>Module</tt></NOBR></td><td><NOBR><tt>Action</tt></NOBR></td>");
	out.println("<td><NOBR><tt>Event</tt></NOBR></td>");
	out.println("</TR>");

	try{
		rset = stmt.executeQuery(stUserProcesses); 
		iCount = 0;
		while (rset.next()) { 
			if (iCount%2 == 0) { 
				out.println("<TR class=\"table-separator-even\">");
			}
			else {
				out.println("<TR class=\"table-separator-odd\">");
			} 
	out.println("<td><input type=\"button\" value=\"Cursor\" name=\"c_button\" onClick=\"javascript:document.MAIN_CURSOR_ALERT.p_cursor_alert.value=" + rset.getInt("sid") + ";document.MAIN_CURSOR_ALERT.submit();\"></td>");
	out.println("<td><input type=\"button\" value=\"Kill Session\" name=\"p_button\" onClick=\"javascript:kill_session(" + rset.getInt("sid") + "," + rset.getString("serial#") + ");\"></td>");
	out.println("<TD><NOBR><tt>" + rset.getString("osuser") + "</tt></NOBR></td><TD><NOBR><tt>" + rset.getString("username") + "</tt></NOBR></td>");
	out.println("<TD><NOBR><tt>" + rset.getInt("sid") + "</tt></NOBR></td><td><NOBR><tt>" + rset.getString("serial#") + "</tt></NOBR></td><td><NOBR><tt>" + rset.getInt("pid") + "</tt></NOBR></td>");
	out.println("<td><NOBR><tt>" + rset.getString("shadow") + "</tt></NOBR></td><td><NOBR><tt>" + rset.getString("process") + "</tt></NOBR></td><td><NOBR><tt>" + rset.getString("program") + "</tt></NOBR></td>");
	out.println("<td><NOBR><tt>" + rset.getString("terminal") + "</tt></NOBR></td><td><NOBR><tt>" + rset.getString("time") + "</tt></NOBR></td><td><NOBR><tt>" + rset.getString("status") + "</tt></NOBR></td>");
	out.println("<td><NOBR><tt>" + rset.getString("last_call_et") + "</tt></NOBR></td><td><NOBR><tt>" + rset.getString("module") + "</tt></NOBR></td>");
	out.println("<td><NOBR><tt>" + rset.getString("action") + "</tt></NOBR></td><td><NOBR><tt>" + rset.getString("event") + "</tt></NOBR></td></TR>");
		iCount++;
		} //end while (rset.next()) 
	} catch (Exception e2) 
		{
			out.println("Error At System User and Process Info");
			out.println(e2.toString());
		}
	if (rset != null)
		rset.close();
	out.println("</TABLE>");
}

private void printUsers(JspWriter out, String stUsers) throws SQLException, IOException
{
	int iCount;
	out.println("<hr>");
	out.println("<FONT face=\"Verdana\" size=\"4\" color=\"#008080\">");
	out.println("Currently Logged In Users:");
	out.println("</FONT>");

	out.println("<TABLE cellspacing=\"1\" cellpadding=\"1\">");
	out.println("<TR class=\"table-header\">");
	out.println("<TD><NOBR><tt>User Name</tt></NOBR></TD><TD><NOBR><tt>Count</tt></NOBR></TD>");
	out.println("<TD><NOBR><tt>Shadow</tt></NOBR></TD><TD><NOBR><tt>Process</tt></NOBR></TD><TD><NOBR><tt>Program</tt></NOBR></TD><TD><NOBR><tt>Start Time</tt></NOBR></TD>");
	out.println("<TD><NOBR><tt>End Time</tt></NOBR></TD>");
	out.println("</TR>");
	try{
		rset = stmt.executeQuery(stUsers); 
		iCount = 0; 
		while (rset.next()) { 
			if (iCount%2 == 0) { 
				out.println("<TR class=\"table-separator-even\">");
			} 
			else {
				out.println("<TR class=\"table-separator-odd\">");
			}
	out.println("<TD><NOBR><tt>" + rset.getString("user_name") + "</tt></NOBR></td><TD><NOBR><tt>" + rset.getString("count") + "</tt></NOBR></td>");
	out.println("<TD><NOBR><tt>" + rset.getString("shadow") + "</tt></NOBR></td><td><NOBR><tt>" + rset.getString("process") + "</tt></NOBR></td><td><NOBR><tt>" + rset.getString("program") + "</tt></NOBR></td>");
	out.println("<td><NOBR><tt>" + rset.getString("st") + "</tt></NOBR></td><td><NOBR><tt>" + rset.getString("end_time") + "</tt></NOBR></td></TR>");
		iCount++;
		} //end while (rset.next()) 
	} catch (Exception e3) 
		{
			out.println("Error At Logged In Users");
			out.println(e3.toString());
		}
	if (rset != null)
		rset.close();
	out.println("</TABLE>");
}

private void printProcesses(JspWriter out, String stProcesses) throws SQLException, IOException
{
	int iCount;
	out.println("<hr>");
	out.println("<FONT face=\"Verdana\" size=\"4\" color=\"#008080\">");
	out.println("Current System Process Information: (Lists all Oracle Processes):");
	out.println("</FONT>");

	out.println("<TABLE cellspacing=\"1\" cellpadding=\"1\">");
	out.println("<TR class=\"table-header\">");
										
	out.println("<TD><NOBR><tt>&nbsp;</tt></NOBR></TD><TD><NOBR><tt>&nbsp;</tt></NOBR></TD><TD><NOBR><tt>Session ID</tt></NOBR></TD><TD><NOBR><tt>Serial #</tt></NOBR></TD>");
	out.println("<TD><NOBR><tt>Process ID</tt></NOBR></TD><TD><NOBR><tt>O/S User</tt></NOBR></TD><TD><NOBR><tt>Username</tt></NOBR></TD><TD><NOBR><tt>Process</tt></NOBR></TD>");
	out.println("<TD><NOBR><tt>Shadow</tt></NOBR></TD><TD><NOBR><tt>Terminal</tt></NOBR></TD><td><NOBR><tt>Program</tt></NOBR></td>");
	out.println("</TR>");
	try{
		rset = stmt.executeQuery(stProcesses); 
		iCount = 0;
		while (rset.next()) { 
			if (iCount%2 == 0) { 
				out.println("<TR class=\"table-separator-even\">");
			} 
			else {
				out.println("<TR class=\"table-separator-odd\">");
			}
	out.println("<td><input type=\"button\" value=\"Cursor\" name=\"c_button\" onClick=\"javascript:document.MAIN_CURSOR_ALERT.p_cursor_alert.value=" + rset.getInt("sid") + ";document.MAIN_CURSOR_ALERT.submit();\"></td>");
	out.println("<td><input type=\"button\" value=\"Kill Session\" name=\"p_button\" onClick=\"javascript:kill_session(" + rset.getInt("sid") + "," + rset.getString("serial#") + ");\"></td>");
	out.println("<TD><NOBR><tt>" + rset.getInt("sid") + "</tt></NOBR></td><td><NOBR><tt>" + rset.getString("serial#") + "</tt></NOBR></td><td><NOBR><tt>" + rset.getInt("pid") + "</tt></NOBR></td>");
	out.println("<TD><NOBR><tt>" + rset.getString("osuser") + "</tt></NOBR></td><TD><NOBR><tt>" + rset.getString("username") + "</tt></NOBR></td>");
	out.println("<td><NOBR><tt>" + rset.getString("process") + "</tt></NOBR></td><td><NOBR><tt>" + rset.getString("shadow") + "</tt></NOBR></td><td><NOBR><tt>" + rset.getString("terminal") + "</tt></NOBR></td>");
	out.println("<td><NOBR><tt>" + rset.getString("program") + "</tt></NOBR></td></TR>");
		iCount++; 
		} //end while (rset.next()) 
	} catch (Exception e4) 
		{
			out.println("Error At Process Info");
			out.println(e4.toString());
		}
	if (rset != null) 
		rset.close(); 
	out.println("</TABLE>");
}
%>

<%
//************************************************************************************
//* End Variable and Function Definition/Initialization
//************************************************************************************

//************************************************************************************
//* Get Request Parameters to detect if the user is Killing a Session or Executing a Query
//************************************************************************************

stIsAlert = request.getParameter("p_is_alert");
stIsKill = request.getParameter("p_is_kill");
stAlertSession = request.getParameter("p_cursor_alert");
stAlertQuery = "select a.sql_text from v$sqlarea a, v$session b " +
					  "where b.sid = " + stAlertSession + " and b.sql_hash_value = a.hash_value and b.sql_address = a.address " + 
			   "UNION select a.sql_text from v$sqlarea a, v$session b " +
               "where b.sid = " + stAlertSession + " and b.prev_hash_value = a.hash_value and b.prev_sql_addr = a.address";
stIsSQLQuery = request.getParameter("execute_query");

try{

printHeader(out);

if(stIsAlert != null && !stIsAlert.equals(""))
{
	out.println("<hr><br>Cursor (w/ Session ID: " + stAlertSession + ") SQL Statement:<br>");
	rset = stmt.executeQuery(stAlertQuery);
	if(rset.next())
	{    
		out.println(rset.getString("sql_text") + "<br><br>");
	}
	else
	{
		out.println("Cursor with Session ID: " + stAlertSession + " Not Found.<br>");
	}
}

if(stIsKill != null && !stIsKill.equals(""))
{
	killSession(request.getParameter("p_kill_sid"), request.getParameter("p_kill_serial"), conn, out);
}

if(stIsSQLQuery != null && stIsSQLQuery.equals("true"))
{
	executeSQLQuery(request.getParameter("sql_query"), conn, out);
}
else
{
	System.out.println("stQueryLock:"+stQueryLock);
	System.out.println("stUserProcesses:"+stUserProcesses);
	System.out.println("stUsers:"+stUsers);
	System.out.println("stProcesses:"+stProcesses);
	printQueryEnter(out);
	printLocks(out, stQueryLock);
	printUserProcesses(out, stUserProcesses);
	printUsers(out, stUsers);
	printProcesses(out, stProcesses);
%>

<form ACTION="" METHOD="POST"  NAME="MAIN_LOCK_KILLER" >
<input type="hidden" name="p_kill_sid">
<input type="hidden" name="p_kill_serial">
<input type="hidden" name="p_is_kill" value="true">
</form>
<form ACTION="" METHOD="POST"  NAME="MAIN_CURSOR_ALERT" >
<input type="hidden" name="p_kill_sid">
<input type="hidden" name="p_kill_serial">
<input type="hidden" name="p_cursor_alert">
<input type="hidden" name="p_is_alert" value="true">
</form>

</body>
</html>
<% if (rset != null) rset.close(); %>
<% if (stmt != null) stmt.close(); %>
<% if (conn != null) conn.close(); %>
<%
} //end else if not SQL Query
} catch (Exception e) 
	{
		out.println("Main Error");
		out.println(e.toString());
		e.fillInStackTrace();
		e.printStackTrace();
		out.println(e.getMessage());
	}
%>