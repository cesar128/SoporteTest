using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using SoporteTest1;

namespace SoporteTest1.Controllers
{
    public class DeptoTIController : Controller
    {
        private Entities db = new Entities();

        // GET: DeptoTI
        [Authorize]
        public ActionResult Index()
        {
            if (Request.IsAuthenticated)
            {  //Segun el PDF si el usuario no esta autentificado, 
               //se muestran todos los reportes
               //De lo contrario se mostraran solo sus reportes
               //siempre y cuando no sea administrador, que ahi se muestran todos igual
               //con la posibilidad de editarlos...

                if (User.IsInRole("Admin"))
                {
                    return View(db.DepartamentoTIs.ToList());
                }
                else return RedirectToRoute("Index","Tickets");
            }
            else return RedirectToRoute("Index", "Tickets");

        }

        // GET: DeptoTI/Details/5
        [Authorize]
        public ActionResult Details(int? id)
        {
            if (Request.IsAuthenticated)
            { 
                if (!User.IsInRole("Admin"))
                {
                    if (id == null)
                                {
                                    return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
                                }
                                DepartamentoTI departamentoTI = db.DepartamentoTIs.Find(id);
                                if (departamentoTI == null)
                                {
                                    return HttpNotFound();
                                }

                                return View(departamentoTI);

                                    }
                        else return RedirectToRoute("Tickets");
            }
            else return RedirectToRoute("Tickets");
}

        // GET: DeptoTI/Create
        [Authorize]
        public ActionResult Create()
        {
            return View();
        }

        // POST: DeptoTI/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        [Authorize]
        public ActionResult Create([Bind(Include = "Id,DeptoTI")] DepartamentoTI departamentoTI)
        {
            if (ModelState.IsValid)
            {
                db.DepartamentoTIs.Add(departamentoTI);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(departamentoTI);
        }

        // GET: DeptoTI/Edit/5
        [Authorize]
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            DepartamentoTI departamentoTI = db.DepartamentoTIs.Find(id);
            if (departamentoTI == null)
            {
                return HttpNotFound();
            }
            return View(departamentoTI);
        }

        // POST: DeptoTI/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        [Authorize]
        public ActionResult Edit([Bind(Include = "Id,DeptoTI")] DepartamentoTI departamentoTI)
        {
            if (ModelState.IsValid)
            {
                db.Entry(departamentoTI).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(departamentoTI);
        }

        // GET: DeptoTI/Delete/5
        [Authorize]
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            DepartamentoTI departamentoTI = db.DepartamentoTIs.Find(id);
            if (departamentoTI == null)
            {
                return HttpNotFound();
            }
            return View(departamentoTI);
        }

        // POST: DeptoTI/Delete/5
        [Authorize]
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            DepartamentoTI departamentoTI = db.DepartamentoTIs.Find(id);
            db.DepartamentoTIs.Remove(departamentoTI);
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
