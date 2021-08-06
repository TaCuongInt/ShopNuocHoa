using System;
using PagedList;
using System.Net;
using System.Web;
using System.Data;
using System.Linq;
using Nhom_1.Models;
using System.Web.Mvc;
using System.Data.Entity;
using System.Collections.Generic;

namespace Nhom_1.Areas.Admin.Controllers
{
    public class DanhMucSPsController : Controller
    {
        private ShopNuocHoaDB db = new ShopNuocHoaDB();

        // GET: Admin/DanhMucSPs
        public ActionResult Index(string sortOrder, string searchString, string curentFilter, int? page)
        {
            if (Session["tenTK"] != null && (Session["quyen"].Equals(1) || Session["quyen"].Equals(3)))
            {
                ViewBag.SapTheoMa = sortOrder == "Ma" ? "ma_desc" : "Ma";
                ViewBag.SapTheoTen = String.IsNullOrEmpty(sortOrder) ? "ten_desc" : "";

                if (searchString != null)
                {
                    page = 1;
                }
                else
                {
                    searchString = curentFilter;
                }

                ViewBag.CurentFilter = searchString;
                var danhmucs = db.DanhMucSPs.Select(c => c);

                if (!String.IsNullOrEmpty(searchString))
                {
                    danhmucs = danhmucs.Where(s => s.Ten_DM.Contains(searchString));
                }
                switch (sortOrder)
                {
                    case "ma_desc":
                        danhmucs = danhmucs.OrderByDescending(c => c.Ma_DM);
                        break;
                    case "ten_desc":
                        danhmucs = danhmucs.OrderByDescending(c => c.Ten_DM);
                        break;
                    default:
                        danhmucs = danhmucs.OrderBy(c => c.Ma_DM);
                        break;
                }
                int pageSize = 5;
                int pageNumber = (page ?? 1);

                return View(danhmucs.ToPagedList(pageNumber, pageSize));
            }
            else
            {
                return RedirectToAction("Login", "Home");
            }
        }

        // GET: Admin/DanhMucSPs/Details/5
        public ActionResult Details(int? id)
        {
            if (Session["tenTK"] != null && (Session["quyen"].Equals(1) || Session["quyen"].Equals(3)))
            {
                if (id == null)
                {
                    return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
                }
                DanhMucSP danhMucSPs = db.DanhMucSPs.Find(id);
                if (danhMucSPs == null)
                {
                    return HttpNotFound();
                }
                return View(danhMucSPs);
            }
            else
            {
                return RedirectToAction("Login", "Home");
            }
        }

        // GET: Admin/DanhMucSPs/Create
        public ActionResult Create()
        {
            if (Session["tenTK"] != null && (Session["quyen"].Equals(1) || Session["quyen"].Equals(3)))
            {
                return View();
            }
            else
            {
                return RedirectToAction("Login", "Home");
            }
        }

        // POST: Admin/DanhMucSPs/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "Ma_DM,Ten_DM,Icon,Anh")] DanhMucSP danhMucSP)
        {
            try
            {
                var f = Request.Files["icon"];
                var f1 = Request.Files["anh"];

                DanhMucSP danhMuc = new DanhMucSP();

                danhMuc.Ten_DM = Request.Form["tenDM"];
                danhMuc.Icon = System.IO.Path.GetFileName(f.FileName);
                danhMuc.Anh = System.IO.Path.GetFileName(f1.FileName);

                db.DanhMucSPs.Add(danhMuc);
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            catch (Exception ex)
            {
                ViewBag.Error = "Lỗi nhập dữ liệu! " + ex.Message;
                return View();
            }
        }

        // GET: Admin/DanhMucSPs/Edit/5
        public ActionResult Edit(int? id)
        {
            if (Session["tenTK"] != null && (Session["quyen"].Equals(1) || Session["quyen"].Equals(3)))
            {
                if (id == null)
                {
                    return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
                }
                DanhMucSP danhMucSPs = db.DanhMucSPs.Find(id);
                if (danhMucSPs == null)
                {
                    return HttpNotFound();
                }
                return View(danhMucSPs);
            }
            else
            {
                return RedirectToAction("Login", "Home");
            }
        }

        // POST: Admin/DanhMucSPs/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "Ma_DM,Ten_DM,Icon,Anh")] DanhMucSP danhMucSP)
        {
            int maDM = Convert.ToInt32(Request.Form["maDM"]);
            DanhMucSP danhMuc = db.DanhMucSPs.Where(c => c.Ma_DM == maDM).FirstOrDefault();
            if (Request != null && danhMuc != null)
            {
                try
                {
                    danhMuc.Ten_DM = Request.Form["tenDM"];

                    if (Request.Files["icon"].FileName != "")
                    {
                        danhMuc.Icon = System.IO.Path.GetFileName(Request.Files["icon"].FileName);
                    }
                    if (Request.Files["anh"].FileName != "")
                    {
                        danhMuc.Anh = System.IO.Path.GetFileName(Request.Files["anh"].FileName);
                    }

                    db.Entry(danhMuc).State = EntityState.Modified;
                    db.SaveChanges();
                    return RedirectToAction("Index");
                }
                catch (Exception ex)
                {
                    ViewBag.Error = "Lỗi nhập dữ liệu! " + ex.Message;
                    return View(danhMuc);
                }
            }
            else
            {
                ViewBag.Error = "Lỗi nhập dữ liệu!";
                return View(danhMuc);
            }
        }

        // GET: Admin/DanhMucSPs/Delete/5
        public ActionResult Delete(int? id)
        {
            if (Session["tenTK"] != null && (Session["quyen"].Equals(1) || Session["quyen"].Equals(3)))
            {
                if (id == null)
                {
                    return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
                }
                DanhMucSP danhMucSPs = db.DanhMucSPs.Find(id);
                if (danhMucSPs == null)
                {
                    return HttpNotFound();
                }
                return View(danhMucSPs);
            }
            else
            {
                return RedirectToAction("Login", "Home");
            }
        }

        // POST: Admin/DanhMucSPs/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            DanhMucSP danhMucSPs = db.DanhMucSPs.Find(id);
            if (danhMucSPs.SanPhams.Count() > 0)
            {
                ViewBag.Error = "Danh mục vẫn còn sản phẩm";
                return View(danhMucSPs);
            }
            else
            {
                try
                {
                    db.DanhMucSPs.Remove(danhMucSPs);
                    db.SaveChanges();
                    return RedirectToAction("Index");
                }
                catch (Exception ex)
                {
                    ViewBag.Error = "Lỗi! " + ex.Message;
                    return View(danhMucSPs);
                }
            }
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
