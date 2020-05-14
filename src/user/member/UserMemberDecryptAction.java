package user.member;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.KeyFactory;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.spec.RSAPublicKeySpec;

import javax.crypto.Cipher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.db.BoardDAO;
import user.db.UserDAO;

import static user.member.UserMemberEncryptAction.cipher;

public class UserMemberDecryptAction implements Action {

	private String decryptRsa(PrivateKey privateKey, String securedValue) throws Exception {
        System.out.println("will decrypt : " + securedValue);
        byte[] encryptedBytes = hexToByteArray(securedValue);
        cipher.init(Cipher.DECRYPT_MODE, privateKey);
        byte[] decryptedBytes = cipher.doFinal(encryptedBytes);
        String decryptedValue = new String(decryptedBytes, "utf-8"); // 문자 인코딩 주의.
        return decryptedValue;
    }

    /**
     * 16진 문자열을 byte 배열로 변환한다.
     */
    public static byte[] hexToByteArray(String hex) {
        if (hex == null || hex.length() % 2 != 0) {
            return new byte[]{};
        }

        byte[] bytes = new byte[hex.length() / 2];
        for (int i = 0; i < hex.length(); i += 2) {
            byte value = (byte)Integer.parseInt(hex.substring(i, i + 2), 16);
            bytes[(int) Math.floor(i / 2)] = value;
        }
        return bytes;
    }
	
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
// 복호화
		ActionForward forward = new ActionForward();
		UserDAO userDAO = new UserDAO();
		HttpSession session = request.getSession();
		
		String SecureduserID = request.getParameter("securedUserID");
		String Securedpassword = request.getParameter("securedPassword");
		
		PrivateKey privateKey = (PrivateKey) session.getAttribute("__rsaPrivateKey__");
                
        if(privateKey == null) {
        	throw new RuntimeException("암호화 비밀키 정보를 찾을 수 없습니다.");
        }
        
        session.removeAttribute("__rsaPrivateKey__"); // 키의 재사용을 막는다. 항상 새로운 키를 받도록 강제.
        
        try {
            String userID = decryptRsa(privateKey, SecureduserID);
            String userpassword = decryptRsa(privateKey, Securedpassword);
           
            int result = userDAO.logIn(userID, userpassword);
            
            	if (result == 1) {
    			
    			session.setAttribute("userID", userID);
    			forward.setRedirect(true);
    			forward.setPath("/boardWrite.jsp");
    			return forward;
    			/*
    			 * if(resultOld == false) { forward.setRedirect(true);
    			 * forward.setPath("boardWrite.jsp"); return forward; }else if(resultOld ==
    			 * true) { forward.setRedirect(true); forward.setPath("/bring.tb"); return
    			 * forward; }
    			 */	
    			}else if (result == 0) {
    				response.setContentType("text/html; charset=utf-8");// 안해주면 깨진다
    				PrintWriter out = response.getWriter();
    				out.println("<script>");
    				out.println("alert('존재하지 않는 비밀번호입니다.');");
    				out.println("history.back();");
    				out.println("</script>");
    				out.close();
    			} else if (result == -1) {
    				response.setContentType("text/html; charset=utf-8");
    				PrintWriter out = response.getWriter();
    				out.println("<script>");
    				out.println("alert('존재하지 않는 아이디입니다.');");
    				out.println("history.back();");
    				out.println("</script>");
    				out.close();
    			} else if (result == -2) {
    				response.setContentType("text/html; charset=utf-8");
    				PrintWriter out = response.getWriter();
    				out.println("<script>");
    				out.println("alert('UNKNOWN ERROR');");
    				out.println("history.back();");
    				out.println("</script>");
    				out.close();
    			} 
            	
    			return forward;
    			
        } catch (Exception ex) {
            throw new ServletException(ex.getMessage(), ex);
        }
    }
}
