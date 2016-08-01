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


namespace SoporteTest1.Controllers
{
    public class TicketsController : Controller
    {
        private Entities db = new Entities();

        // GET: Tickets
        public ActionResult Index()
        {
            object tickets = null;

            if (Request.IsAuthenticated)
            {
                var uid = User.Identity.GetUserId();
                tickets = db.Tickets.Where(t => t.OwnerID == uid).Include(t => t.AspNetUser).Include(t => t.AspNetUser1).Include(t => t.DepartamentoTI).Include(t => t.Estatu);
            } else {
                tickets = db.Tickets.Include(t => t.AspNetUser).Include(t => t.AspNetUser1).Include(t => t.DepartamentoTI).Include(t => t.Estatu);
            }


            return View(tickets);
        }

        // GET: Tickets/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Ticket ticket = db.Tickets.Find(id);
            if (ticket == null)
            {
                return HttpNotFound();
            }
            return View(ticket);
        }

        // GET: Tickets/Create
        [Authorize]
        public ActionResult Create()
        {
            ViewBag.Asig_id = new SelectList(db.AspNetUsers, "Id", "Email");
            ViewBag.OwnerID = new SelectList(db.AspNetUsers, "Id", "Email");
            ViewBag.DepartamentoPertenece = new SelectList(db.DepartamentoTIs, "Id", "DeptoTI");
            ViewBag.Estatus_ID = new SelectList(db.Estatus, "Id", "Estado");
            return View();
        }

        // POST: Tickets/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        [Authorize]
        public ActionResult Create([Bind(Include = "Id,OwnerID,Titulo,Descripcion,Date_added,Date_solved,Asig_id,Estatus_ID,DepartamentoPertenece")] Ticket ticket)
        {
            if (ModelState.IsValid)
            {
                ticket.OwnerID = User.Identity.GetUserId();
                ticket.Date_added = DateTime.Now;
                ticket.Estatus_ID = 1;
                db.Tickets.Add(ticket);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.Asig_id = new SelectList(db.AspNetUsers, "Id", "Email", ticket.Asig_id);
            ViewBag.OwnerID = new SelectList(db.AspNetUsers, "Id", "Email", ticket.OwnerID);
            ViewBag.DepartamentoPertenece = new SelectList(db.DepartamentoTIs, "Id", "DeptoTI", ticket.DepartamentoPertenece);
            ViewBag.Estatus_ID = new SelectList(db.Estatus, "Id", "Estado", ticket.Estatus_ID);
            return View(ticket);
        }

        // GET: Tickets/Edit/5
        [Authorize]
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Ticket ticket = db.Tickets.Find(id);
            if (ticket == null)
            {
                return HttpNotFound();
            }
            ViewBag.Asig_id = new SelectList(db.AspNetUsers, "Id", "Email", ticket.Asig_id);
            ViewBag.OwnerID = new SelectList(db.AspNetUsers, "Id", "Email", ticket.OwnerID);
            ViewBag.DepartamentoPertenece = new SelectList(db.DepartamentoTIs, "Id", "DeptoTI", ticket.DepartamentoPertenece);
            ViewBag.Estatus_ID = new SelectList(db.Estatus, "Id", "Estado", ticket.Estatus_ID);
            return View(ticket);
        }

        // POST: Tickets/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [Authorize]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "Id,OwnerID,Titulo,Descripcion,Asig_id,Estatus_ID,DepartamentoPertenece")] Ticket ticket)
        {
            if (ModelState.IsValid)
            {
                ticket.Date_added = System.DateTime.Now;
                db.Entry(ticket).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.Asig_id = new SelectList(db.AspNetUsers, "Id", "Email", ticket.Asig_id);
            ViewBag.OwnerID = new SelectList(db.AspNetUsers, "Id", "Email", ticket.OwnerID);
            ViewBag.DepartamentoPertenece = new SelectList(db.DepartamentoTIs, "Id", "DeptoTI", ticket.DepartamentoPertenece);
            ViewBag.Estatus_ID = new SelectList(db.Estatus, "Id", "Estado", ticket.Estatus_ID);
            return View(ticket);
        }

        // GET: Tickets/Delete/5
        [Authorize]
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Ticket ticket = db.Tickets.Find(id);
            if (ticket == null)
            {
                return HttpNotFound();
            }
            return View(ticket);
        }

        // POST: Tickets/Delete/5
        [HttpPost, ActionName("Delete")]
        [Authorize]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Ticket ticket = db.Tickets.Find(id);
            db.Tickets.Remove(ticket);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        // GET: Tickets
        public ActionResult Rep()
        {

            ViewBag.Pendientes = db.Tickets.Count(c => c.Estatus_ID == 1);
            ViewBag.EnProceso = db.Tickets.Count(c => c.Estatus_ID == 2);
            ViewBag.Cerrados = db.Tickets.Count(c => c.Estatus_ID == 3);

            return View();
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
