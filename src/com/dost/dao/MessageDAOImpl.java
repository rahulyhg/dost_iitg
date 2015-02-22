package com.dost.dao;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dost.hibernate.DbMessage;
import com.dost.hibernate.DbMessageRecipient;

@Repository("messageDAO")
public class MessageDAOImpl implements MessageDAO {

	@Autowired
	SessionFactory sessionFactory;
	
	public List<DbMessage> getAllUserMessagesById(Long id, String pageNo, String per_page, String sort, String order) {
		Session session = sessionFactory.getCurrentSession();
		String hql = "from DbMessage m where m.msgId in (select mi.msgId from DbMessage mi where mi.sender.userId = ?)";
		if(sort != null && order != null) {
			hql = hql +  "order by " + sort + " " + order;
		}
        Query query = session.createQuery(hql);
        query.setParameter(0, id);
        if(pageNo != null && per_page != null) {
            query.setFirstResult((Integer.parseInt(pageNo) - 1) * Integer.parseInt(per_page));
            query.setMaxResults(Integer.parseInt(per_page));
        }
        List<DbMessage> messages = query.list();
        if(messages == null) {
        	return new ArrayList<DbMessage>();
        }
        return messages;
	}

	public List<DbMessage> getMessagesById(Long id) {
		Session session = sessionFactory.getCurrentSession();
//		String hql = "from DbMessage m join fetch m.recipients r where r.recipient.userId = ? and m.deleted = 0 and r.deleted = 0";
		String hql = "from DbMessage m where m.msgId = ?";
        Query query = session.createQuery(hql);
        query.setParameter(0, id);
        
        List<DbMessage> messages = query.list();
        if(messages == null) {
        	return new ArrayList<DbMessage>();
        }
        return messages;		
	}
	
	public List<DbMessage> getUserMessages(Long userId, String pageNo, String per_page, String sort, String order) {
		Session session = sessionFactory.getCurrentSession();
//		String hql = "from DbMessage m join fetch m.recipients r where r.recipient.userId = ? and m.deleted = 0 and r.deleted = 0";
//		String hql = "from DbMessage where msgId in (select distinct m.msgId from DbMessage m inner join m.recipients r where r.recipient.userId = ? order by m." + sort + " " + order + ")";
		String hql = "select m.msgId from DbMessage m inner join m.recipients r where r.recipient.userId = ? order by m.messageId desc";// + order;
		Query query = session.createQuery(hql);
        query.setParameter(0, userId);
        if(pageNo != null && per_page != null) {
        	query.setFirstResult((Integer.parseInt(pageNo) - 1) * Integer.parseInt(per_page));
        }
        List<Long> msgIdList = query.list();
        if(msgIdList == null) {
        	return new ArrayList<DbMessage>();
        }
        Set<Long> msgIdSet = new LinkedHashSet<Long>(msgIdList);
        msgIdList = new ArrayList<Long>(msgIdSet);
        if(pageNo != null && per_page != null) {
            if(msgIdList.size() > (Integer.parseInt(pageNo)) * Integer.parseInt(per_page)) {
//            	msgIdList = msgIdList.subList((Integer.parseInt(pageNo) - 1) * Integer.parseInt(per_page), (Integer.parseInt(pageNo)) * Integer.parseInt(per_page));
            	msgIdList = msgIdList.subList(0, Integer.parseInt(per_page));
            }
            else {
            	msgIdList = msgIdList.subList(0, msgIdList.size());
            }        	
        }
        List<DbMessage> msgList = new ArrayList<DbMessage>();
        if(msgIdList.size() > 0) {
            String hqlMessages = "from DbMessage m inner join fetch m.recipients r where m.msgId in (:list) and r.recipient.userId = :userId order by m.messageId";
    		Query queryMessages = session.createQuery(hqlMessages);
    		queryMessages.setParameterList("list", msgIdList);
    		queryMessages.setParameter("userId", userId);
    		msgList = queryMessages.list();
    		if(msgList == null) {
    			return new ArrayList<DbMessage>();
    		}
        	
        }
        return msgList;
	}

	public List<DbMessage> getDraftUserMessages(Long userId) {
		// TODO Auto-generated method stub
		return null;
	}

	public List<DbMessage> getSentUserMessages(Long userId, String pageNo, String per_page, String sort, String order) {
		Session session = sessionFactory.getCurrentSession();
//		String hql = "select m from DbMessage m left outer join fetch m.recipients r where m.sender.userId = ? and m.deleted = 0";
//		String hql = "select m from DbMessage m left outer join fetch m.recipients r where m.sender.userId = ?";

		String hql = "select m.msgId from DbMessage m where m.sender.userId = ? order by m.messageId desc";// + order;
		Query query = session.createQuery(hql);
        query.setParameter(0, userId);
        query.setFirstResult((Integer.parseInt(pageNo) - 1) * Integer.parseInt(per_page));
        List<Long> msgIdList = query.list();
        if(msgIdList == null) {
        	return new ArrayList<DbMessage>();
        }
        Set<Long> msgIdSet = new LinkedHashSet<Long>(msgIdList);
        msgIdList = new ArrayList<Long>(msgIdSet);
        if(msgIdList.size() > (Integer.parseInt(pageNo)) * Integer.parseInt(per_page)) {
//        	msgIdList = msgIdList.subList((Integer.parseInt(pageNo) - 1) * Integer.parseInt(per_page), (Integer.parseInt(pageNo)) * Integer.parseInt(per_page));
        	msgIdList = msgIdList.subList(0, Integer.parseInt(per_page));
        }
        else {
        	msgIdList = msgIdList.subList(0, msgIdList.size());
        }
        
        List<DbMessage> msgList = new ArrayList<DbMessage>();
        if(msgIdList.size() > 0) {
            String hqlMessages = "from DbMessage m where m.msgId in (:list) and m.sender.userId = :userId order by m.messageId";
    		Query queryMessages = session.createQuery(hqlMessages);
    		queryMessages.setParameterList("list", msgIdList);
    		queryMessages.setParameter("userId", userId);
    		msgList = queryMessages.list();
    		if(msgList == null) {
    			return new ArrayList<DbMessage>();
    		}        	
        }
        return msgList;
	}

	public DbMessage getMessageDetails(Long id) {
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("from DbMessage m where m.id = ?");
        query.setParameter(0, id);
        DbMessage dbMessage = (DbMessage) query.uniqueResult();
        return dbMessage;
	}

	public void setViewed(Long id, Long userId) {
		Session session = sessionFactory.getCurrentSession();
//		DbMessage message = getMessageDetails(id);
		List<DbMessage> messagesByMsgId = getMessagesById(id);
		for(DbMessage message : messagesByMsgId) {
			for (Iterator i = message.getRecipients().iterator(); i.hasNext();) {
				DbMessageRecipient recipient = (DbMessageRecipient) i.next();
				if(recipient.getRecipient().getUserId().longValue() == userId) {
					recipient.setViewed(1l);
					session.saveOrUpdate(recipient);
				}
			}			
		}
	}
	
	public void sendMessage(DbMessage dbMessage) {
		Session session = sessionFactory.getCurrentSession();
		
		//dbMessage.setSentDateDb(new Date(1));
		dbMessage.setSentDateDb(null);
//		List<DbMessageRecipient> recipients = dbMessage.getRecipients();
//		for(DbMessageRecipient recipient : recipients) {
//			//recipient.setMessage(dbMessage);
//			session.saveOrUpdate(recipient);
//		}
		session.save(dbMessage);
	}
	
	public Long getMaxMsgId() {
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("select max(m.msgId) from DbMessage m ");
		return (Long)query.uniqueResult();
		
	}

	public Long getMsgCount(Long id) {
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("select count(*) from DbMessage m where m.msgId = :id");
		query.setParameter("id", id);
		return (Long)query.uniqueResult();		
	}
	
	public int getUnreadMessageCount(Long id) {
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("select count(*) from DbMessageRecipient mr where mr.recipient.userId = :id and  mr.viewed = 0");
		query.setParameter("id", id);
		Long count = (Long)query.uniqueResult();
		return count.intValue();
	}
}
