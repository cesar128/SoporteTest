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
    public class UsuariosController : Controller
    {
        private Entities db = new Entities();

        // GET: Usuarios
        public ActionResult Index()
        {
            var aspNetUsers = db.AspNetUsers.Include(a => a.Departamento);
            return View(aspNetUsers.ToList());
        }

        // GET: Usuarios/Details/5
        public ActionResult Details(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            AspNetUser aspNetUser = db.AspNetUsers.Find(id);
            if (aspNetUser == null)
            {
                return HttpNotFound();
            }
            return View(aspNetUser);
        }

        // GET: Usuarios/Edit/5
        public ActionResult Edit(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            AspNetUser aspNetUser = db.AspNetUsers.Find(id);
            if (aspNetUser == null)
            {
                return HttpNotFound();
            }
            ViewBag.Departamento_Id = new SelectList(db.Departamentos, "Id", "Depto", aspNetUser.Departamento_Id);
            return View(aspNetUser);
        }

        // POST: Usuarios/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "Id,Email,Departamento_Id")] AspNetUser aspNetUser)
        {
            var depid = aspNetUser.Departamento_Id.Value;
            //var col2 = db.columns.Where(w => w.category.Equals("Cars"));
            var col1 = db.AspNetUsers.Where(c => c.Id.Equals(aspNetUser.Id));
            foreach (var item in col1)
            {
                item.Departamento_Id = depid;
            }

            try
            {
                db.SaveChanges();
            }
            catch (Exception ex)
            {
                //Handle ex
            }

            //if (ModelState.IsValid)
            //{
            //    db.Entry(aspNetUser).State = EntityState.Modified;
            //    db.SaveChanges();
            //    return RedirectToAction("Index");
            //}
            //ViewBag.Departamento_Id = new SelectList(db.Departamentos, "Id", "Depto", aspNetUser.Departamento_Id);
            return RedirectToAction("Index");
        }

        //// GET: Usuarios/Delete/5
        //public ActionResult Delete(string id)
        //{
        //    if (id == null)
        //    {
        //        return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
        //    }
        //    AspNetUser aspNetUser = db.AspNetUsers.Find(id);
        //    if (aspNetUser == null)
        //    {
        //        return HttpNotFound();
        //    }
        //    return View(aspNetUser);
        //}

        //// POST: Usuarios/Delete/5
        //[HttpPost, ActionName("Delete")]
        //[ValidateAntiForgeryToken]
        //public ActionResult DeleteConfirmed(string id)
        //{
        //    AspNetUser aspNetUser = db.AspNetUsers.Find(id);
        //    db.AspNetUsers.Remove(aspNetUser);
        //    db.SaveChanges();
        //    return RedirectToAction("Index");
        //}

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
