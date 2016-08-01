using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using SoporteTest1;

namespace SoporteTest1.Content
{
    public class FollowController : Controller
    {
        private Entities db = new Entities();

        // GET: Follow
        public ActionResult Index()
        {
            var followTables = db.FollowTables.Include(f => f.AspNetUser).Include(f => f.AspNetUser1);
            return View(followTables.ToList());
        }

        // GET: Follow/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            FollowTable followTable = db.FollowTables.Find(id);
            if (followTable == null)
            {
                return HttpNotFound();
            }
            return View(followTable);
        }

        // GET: Follow/Create
        public ActionResult Create(int? id)
        {
            ViewBag.Follow = new SelectList(db.AspNetUsers, "Id", "Email");
            ViewBag.Who = new SelectList(db.AspNetUsers, "Id", "Email");
            return View();
        }

        // POST: Follow/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "ID,Who,Follow")] FollowTable followTable)
        {
            if (ModelState.IsValid)
            {
                db.FollowTables.Add(followTable);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.Follow = new SelectList(db.AspNetUsers, "Id", "Email", followTable.Follow);
            ViewBag.Who = new SelectList(db.AspNetUsers, "Id", "Email", followTable.Who);
            return View(followTable);
        }

        // GET: Follow/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            FollowTable followTable = db.FollowTables.Find(id);
            if (followTable == null)
            {
                return HttpNotFound();
            }
            ViewBag.Follow = new SelectList(db.AspNetUsers, "Id", "Email", followTable.Follow);
            ViewBag.Who = new SelectList(db.AspNetUsers, "Id", "Email", followTable.Who);
            return View(followTable);
        }

        // POST: Follow/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "ID,Who,Follow")] FollowTable followTable)
        {
            if (ModelState.IsValid)
            {
                db.Entry(followTable).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.Follow = new SelectList(db.AspNetUsers, "Id", "Email", followTable.Follow);
            ViewBag.Who = new SelectList(db.AspNetUsers, "Id", "Email", followTable.Who);
            return View(followTable);
        }

        // GET: Follow/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            FollowTable followTable = db.FollowTables.Find(id);
            if (followTable == null)
            {
                return HttpNotFound();
            }
            return View(followTable);
        }

        // POST: Follow/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            FollowTable followTable = db.FollowTables.Find(id);
            db.FollowTables.Remove(followTable);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
