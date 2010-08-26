import wsgiref.handlers
from google.appengine.ext import webapp
from google.appengine.ext import db
from django.utils import simplejson
import cgi

#model
class Comment(db.Model):
    mid = db.IntegerProperty()
    body = db.StringProperty(required=True)
    channel = db.StringProperty(required=True)
    date = db.TimeProperty(auto_now_add=True)

#pages
class RootPage(webapp.RequestHandler):
    def get(self):
        self.response.out.write("<h1>hi</h1>")

class ApiPostPage(webapp.RequestHandler):
    def get(self):
        self.response.content_type = "application/json"
        callback = self.request.get("cb")
        body = self.request.get("bo")
        channel = self.request.get("ch")
        if not(body) or not(channel):
            if not(ch):
                simplejson.dump({"success": False}, self.response.out, ensure_ascii=False)
            else:
                self.response.out.write("%s(%s)" %
                        (callback, simplejson.dumps({"success": False}, ensure_ascii=False)))
        else:
            tmp = Comment.all()
            tmp.filter('channel =',channel).order('-mid')
            if tmp.count() <= 0:
                latest_id = 1
            else:
                latest_id = tmp[0].mid + 1
            comment = Comment(body=cgi.escape(body),channel=channel,mid=latest_id)
            comment.put()
            if not(callback):
                simplejson.dump({"success": True}, self.response.out, ensure_ascii=False)
            else:
                self.response.out.write("%s(%s)" %
                        (callback, simplejson.dumps({"success": True}, ensure_ascii=False)))

class ApiShowPage(webapp.RequestHandler):
    def get(self):
        callback = self.request.get("cb")
        channel = self.request.get("ch")
        last_id = self.request.get("li")
        messages = []
        if not(last_id):
            query = Comment.all()
            query.filter('channel =',channel)
            query.order('-mid')
            results = query.fetch(10)
            for result in results:
                messages.append({"body": result.body,"id": result.mid,"date": result.date.strftime("%Y %m %d %H %M %S")})
        else:
            query = Comment.all()
            query.filter('mid >',int(last_id))
            query.filter('channel =',channel)
            query.order('-mid')
            for result in query:
                messages.append({"body": result.body,"id": result.mid,"date": result.date.strftime("%Y %m %d %H %M %S")})
        if len(messages) > 0:
            data = {"success": True,"messages": messages,"last_id":messages[0]["id"]}
        else:
            data = {"success": True,"messages": messages,"last_id":last_id}
        if not(last_id):
            data["init"] = True
        else:
            data["init"] = False
        if not(callback):
            simplejson.dump(data, self.response.out, ensure_ascii=False)
        else:
            self.response.out.write("%s(%s)" %
                    (callback, simplejson.dumps(data, ensure_ascii=False)))

#main
def main():
    app = webapp.WSGIApplication([
        ('/api/show',ApiShowPage),
        ('/api/post',ApiPostPage),
        ('/',RootPage)
        ])
    wsgiref.handlers.CGIHandler().run(app)
if __name__ == '__main__':
    main()
