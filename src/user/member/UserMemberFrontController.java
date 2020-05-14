	package user.member;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UserMemberFrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	public UserMemberFrontController() {
		super();
		System.out.println("UserMemberFrontController생성 완료!");
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		actionGo(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

	private void actionGo(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		String command = null;
		command = request.getRequestURI().substring(request.getContextPath().length());

		System.out.println("userCommand:" + command);

		ActionForward forward = null;
		Action action = null; // 즉 DAO 로 보내질 요청에 탑재할 변수

		if (command.equals("/encryptAction.go")) {
			System.out.println("여기!");
			action = new UserMemberEncryptAction();
			try {
			forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if (command.equals("/decryptAction.go")) {
			action = new UserMemberDecryptAction();
			try {
			forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if (command.equals("/joinAction.go")) {
			System.out.println("가즈아");
			action = new UserMemberJoinAction();
			//response.sendRedirect(forward.getPath());
			try {
			forward = action.execute(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
		} else if(command.equals("/MemberFindPwAction.go")) {
			action = new MemberFindPwAction();
			try {
			forward = action.execute(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
		} else if (command.equals("/idFindAction.go")) {
			action = new idFindAction();
			try {
			forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} 

	      if(forward != null) {
	          RequestDispatcher rd = request.getRequestDispatcher(forward.getPath());
	          rd.forward(request, response);
	      }
	}
}
