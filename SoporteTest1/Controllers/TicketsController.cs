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
using System.IO;
using System.Text;
using System.Data.Entity.Validation;

namespace SoporteTest1.Controllers
{
    public class TicketsController : Controller
    {
        private Entities db = new Entities();

        // GET: Tickets
        public ActionResult Index()
        {
            List<Ticket> tickets = null;

            if (Request.IsAuthenticated)
            {
                if (!User.IsInRole("Admin"))
                {
                    var uid = User.Identity.GetUserId();
                    //tickets = db.Tickets.Where(t => t.OwnerID == uid).Include(t => t.AspNetUser).Include(t => t.AspNetUser1).Include(t => t.DepartamentoTI).Include(t => t.Estatu);

                    tickets = db.Tickets.Where(a => a.OwnerID == uid).ToList();
                    var p = db.FollowTables.Where(a => a.Who == uid);
                    foreach (var item in p)
                    {
                        var mylist = db.Tickets.Where(a => a.OwnerID == item.Follow);
                        foreach (var u in mylist)
                        {
                            tickets.Add(u);
                        }
                    }
                }
                else { tickets = db.Tickets.ToList(); }


            } else {
                //tickets = db.Tickets.Include(t => t.AspNetUser).Include(t => t.AspNetUser1).Include(t => t.DepartamentoTI).Include(t => t.Estatu);
                tickets = db.Tickets.ToList();
            }


            return View(tickets);
        }

        // GET: Tickets/Details/5
        // Para dar los detalles de los tickets
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
        //Crear Ticket
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
        // Accion del formulario post
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
                var dummy = ticket.Id;
                dummy.ToString();

                if (Request.Files.Count > 0)
                {
                    int i = 0;
                    foreach(var fi in Request.Files) {

                        var file = Request.Files[i];
                        if (file != null && file.ContentLength > 0)
                        {

                            var fileName = Path.GetFileName(file.FileName);
                            StringBuilder sb = new StringBuilder();
                            sb.Append(dummy);
                            sb.Append(fileName);
                            var finalname = sb;
                            var path = Path.Combine(Server.MapPath("~/Content/Uploads/"), finalname.ToString());
                            file.SaveAs(path);

                            Archivo arc = new Archivo();
                            arc.Filename = finalname.ToString();
                            arc.TicketId = ticket.Id;
                            db.Archivos.Add(arc);
                            db.SaveChanges();


                        }
                        i++;
                    }
                }

                return RedirectToAction("Index");
            }

            ViewBag.Asig_id = new SelectList(db.AspNetUsers, "Id", "Email", ticket.Asig_id);
            ViewBag.OwnerID = new SelectList(db.AspNetUsers, "Id", "Email", ticket.OwnerID);
            ViewBag.DepartamentoPertenece = new SelectList(db.DepartamentoTIs, "Id", "DeptoTI", ticket.DepartamentoPertenece);
            ViewBag.Estatus_ID = new SelectList(db.Estatus, "Id", "Estado", ticket.Estatus_ID);
            return View(ticket);
        }

        // GET: Tickets/Edit/5
        // Editar cierto ticket
        //   ----
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

            //Si no es dueno del ticket o admin, no puede editarlo, redirigir a Details del mismo ticket
            if (ticket.OwnerID == User.Identity.GetUserId() || User.IsInRole("Admin"))
            {
                return View(ticket);
            }
            else return RedirectToAction("Details", new { id = id.ToString() });

        }

        // POST: Tickets/Edit/5
        [HttpPost]
        [Authorize]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "Id,OwnerID,Date_added,Titulo,Descripcion,Asig_id,Estatus_ID,DepartamentoPertenece")] Ticket ticket)
        {
            if (ModelState.IsValid)
            {
                if(ticket.Estatus_ID == 3)  //Si el estatus es cancelado/cerrado pone la fecha en el campo.
                {
                    ticket.Date_solved = DateTime.Now;
                }

                try
                {
                    db.Entry(ticket).State = EntityState.Modified;
                    db.SaveChanges();
                }

                catch (DbEntityValidationException e)
                {
                    foreach (var eve in e.EntityValidationErrors)
                    {
                        Console.WriteLine("Entity of type \"{0}\" in state \"{1}\" has the following validation errors:",
                            eve.Entry.Entity.GetType().Name, eve.Entry.State);
                        foreach (var ve in eve.ValidationErrors)
                        {
                            Console.WriteLine("- Property: \"{0}\", Error: \"{1}\"",
                                ve.PropertyName, ve.ErrorMessage);
                        }
                    }
                    throw;
                }
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

        // Para la vista de los reportes
        public ActionResult Rep()
        {

            ViewBag.Pendientes = db.Tickets.Count(c => c.Estatus_ID == 1);
            ViewBag.EnProceso = db.Tickets.Count(c => c.Estatus_ID == 2);
            ViewBag.Cerrados = db.Tickets.Count(c => c.Estatus_ID == 3);

            return View();
        }

        public ActionResult Rep2()
        {

            var i = 0;
            List<string> colores = new List<string>(); 

            colores.Add("ff3333");
            colores.Add("006699");
            colores.Add("006600");
            colores.Add("9900ff");
            colores.Add("cc3399");
            colores.Add("663300");
            colores.Add("33cc33");
            colores.Add("ff00ff");
            colores.Add("593366");
            colores.Add("666633");

            foreach (var a in db.rep_por_depto)
            {
                i++;
            }

            ViewBag.total = i;
            ViewBag.lista = colores;
            ViewBag.departamentos = db.rep_por_depto.ToList();

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
