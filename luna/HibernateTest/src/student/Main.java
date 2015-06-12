package student;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

@SuppressWarnings("deprecation")
public class Main {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		StudentInfo student = new StudentInfo();
		student.setName("JOy");
		student.setRollNo(1);
		
		try{
			SessionFactory sessionF = new Configuration().configure().buildSessionFactory();
			Session sess = sessionF.openSession();
			sess.beginTransaction();
			sess.save(student);
			sess.getTransaction().commit();
			sess.close();
			sessionF.close();
		}
		catch (HibernateException e){
			System.out.println(e);
		}
	}
}
