package com.dost.dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dost.hibernate.DbForumForum;
import com.dost.hibernate.DbForumTopic;

@Repository("forumDAO")
public class ForumDAOImpl implements ForumDAO {

	@Autowired
	private SessionFactory sessionFactory;
	
	public List<DbForumTopic> getLastNTopics(int count) {
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("select ft from DbForumTopic ft inner join ft.forumPosts fp group by ft.topicId order by max(fp.postTime) desc");
		query.setMaxResults(count);
		
		List<DbForumTopic> topics = query.list();
		if(topics == null) {
			topics = new ArrayList<DbForumTopic>();
		}
		return topics;
	}
	
	public List<DbForumForum> getForumList() {
		Session session = sessionFactory.getCurrentSession();
		// TODO: Satya: this is the all forum in live forumId = 6
		Query query = session.createQuery("select ff from DbForumForum ff where ff.forumId not in (6)");
		
		List<DbForumForum> forums = query.list();
		if(forums == null) {
			forums = new ArrayList<DbForumForum>();
		}
		return forums;		
	}

}
