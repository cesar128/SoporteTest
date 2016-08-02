using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using SoporteTest1;
using Microsoft.AspNet.Identity;

namespace SoporteTest1.Content
{
    public class FollowController : Controller
    {
        private Entities db = new Entities();

        // GET: Follow
        public ActionResult Index()
        {
            var followTables = db.FollowTables.Include(f => f.AspNetUser).Include(f => f.AspNetUser1);
            return RedirectToAction("Index", "Usuarios");
            //return View(followTables.ToList());
        }


        // GET: Follow/Create
        //Para crear Relaciones manuales
        public ActionResult Create(int? id)
        {
            ViewBag.Follow = new SelectList(db.AspNetUsers, "Id", "Email");
            ViewBag.Who = new SelectList(db.AspNetUsers, "Id", "Email");
            return View();
        }

        // POST: Follow/Create
        // Para Crear una relacion de seguir al usuario
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




        // POST: Follow/Delete
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Delete([Bind(Include = "Id,Who,Follow")] FollowTable followTablee)
        {
            if (ModelState.IsValid)
            {
                //var get_id = db.FollowTables.Where(a => a.Follow == followTablee.Follow && a.Who == followTablee.Who).Select(e=>e.ID);
                var get_id = db.FollowTables.First(a => a.Follow == followTablee.Follow && a.Who == followTablee.Who).ID;
                FollowTable followTable = db.FollowTables.Find(get_id);
                db.FollowTables.Remove(followTable);
                db.SaveChanges();
                return RedirectToAction("Index", "Usuarios");
            }
            return RedirectToAction("Index", "Usuarios");
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
