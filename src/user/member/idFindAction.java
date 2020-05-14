package user.member;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import user.db.UserDAO;
import user.db.UserDTO;

public class idFindAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{	
		request.setCharacterEncoding("utf-8");
		ActionForward forward = new ActionForward();
		UserDAO userdao = new UserDAO();
		UserDTO member = new UserDTO();

		String name = request.getParameter("userName");
		String email = request.getParameter("userEmail");
		//System.out.println("이름은 "+ name);
		//System.out.println("이메일은 "+ email);
		try {
			member = userdao.findId(name, email);
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("못찾음");
		}
	
		if (member != null) {
			request.setAttribute("userID", member.getID());
			forward.setRedirect(false);
			forward.setPath("./idFind_ok.jsp");

		} else {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('입력한 정보가 일치하지 않습니다.');");
			out.println("history.go(-1);");
			out.println("</script>");
			out.close();
			forward = null;
		}
		return forward;
	}
}
