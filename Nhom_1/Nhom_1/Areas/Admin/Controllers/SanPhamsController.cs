using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using Nhom_1.Models;
using PagedList;

namespace Nhom_1.Areas.Admin.Controllers
{
    public class SanPhamsController : Controller
    {
        private ShopNuocHoaDB db = new ShopNuocHoaDB();

        // GET: Admin/SanPhams
        public ActionResult Index(string sortOrder, string searchString, string curentFilter, int? page)
        {
            if (Session["tenTK"] != null && (Session["quyen"].Equals(1) || Session["quyen"].Equals(3)))
            {
                ViewBag.Current = sortOrder;
                ViewBag.SapTheoMa = sortOrder == "Ma" ? "ma_desc" : "Ma";
                ViewBag.SapTheoTen = String.IsNullOrEmpty(sortOrder) ? "ten_desc" : "";
                ViewBag.SapTheoDM = String.IsNullOrEmpty(sortOrder) ? "tenDM_desc" : "";
                ViewBag.SapTheoSL = sortOrder == "SoLuong" ? "sl_desc" : "SoLuong";
                if (searchString != null)
                {
                    page = 1;
                }    
                else
                {
                    searchString = curentFilter;
                }
                ViewBag.CurentFilter = searchString;
                var sanPhams = db.SanPhams.Include(s => s.DanhMucSP);
                if(!String.IsNullOrEmpty(searchString))
                {
                    sanPhams = db.SanPhams.Where(s => s.Ten_SP.Contains(searchString));
                }    
                switch (sortOrder)
                {
                    case "ma_desc":
                        sanPhams = sanPhams.OrderByDescending(s => s.Ma_SP);
                        break;
                    case "ten_desc":
                        sanPhams = sanPhams.OrderByDescending(s => s.Ten_SP);
                        break;
                    case "tenDM_desc":
                        sanPhams = sanPhams.OrderByDescending(s => s.DanhMucSP.Ten_DM);
                        break;
                    case "sl_desc":
                        sanPhams = sanPhams.OrderByDescending(s => s.SoLuong_SP);
                        break;
                    default:
                        sanPhams = sanPhams.OrderBy(s => s.Ma_SP);
                        break;
                }
                int pageSize = 10;
                int pageNumber = (page??1);
                return View(sanPhams.ToPagedList(pageNumber, pageSize));
            }
            else
            {
                return RedirectToAction("Login", "Home");
            }
        }

        // GET: Admin/SanPhams/Details/5
        public ActionResult Details(int? id)
        {
            if (Session["tenTK"] != null && (Session["quyen"].Equals(1) || Session["quyen"].Equals(3)))
            {
                if (id == null)
                {
                    return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
                }
                SanPham sanPham = db.SanPhams.Find(id);
                if (sanPham == null)
                {
                    return HttpNotFound();
                }
                return View(sanPham);
            }
            else
            {
                return RedirectToAction("Login", "Home");
            }
        }

        // GET: Admin/SanPhams/Create
        public ActionResult Create()
        {
            if (Session["tenTK"] != null && (Session["quyen"].Equals(1) || Session["quyen"].Equals(3)))
            {
                ViewBag.TenDM = db.DanhMucSPs.Select(dm => dm.Ten_DM).Distinct();
                var sanPhams = db.SanPhams.Select(p => p);
                return View(sanPhams);
            }
            else
            {
                return RedirectToAction("Login", "Home");
            }
        }

        // POST: Admin/SanPhams/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "Ma_SP,Ten_SP,Ma_DM,ThuongHieu_SP,MuiHuong_SP,MucDich_SP,SoLuong_SP,NongDo_SP,DungTich_SP,GiaBan_SP,MoTa_SP")] SanPham sanPham)
        {
            try
            {
                string tenDM = Request.Form["tenDM"];
                DanhMucSP dm = db.DanhMucSPs.Where(c => c.Ten_DM.Equals(tenDM)).FirstOrDefault();

                SanPham sp = new SanPham();
                sp.Ten_SP = Request.Form["tenSP"];
                sp.Ma_DM = dm.Ma_DM;
                sp.ThuongHieu_SP = Request.Form["thuongHieu"];
                sp.MuiHuong_SP = Request.Form["muiHuong"];
                sp.MucDich_SP = Request.Form["mucDich"];
                sp.SoLuong_SP = Convert.ToInt32(Request.Form["soLuong"]);
                sp.NongDo_SP = Request.Form["nongDo"];
                sp.DungTich_SP = Convert.ToInt32(Request.Form["dungTich"]);
                sp.GiaBan_SP = Convert.ToInt32(Request.Form["giaBan"]);
                sp.MoTa_SP = Request.Form["moTa"];
                db.SanPhams.Add(sp);
                db.SaveChanges();

                int maSP = db.SanPhams.OrderByDescending(p => p.Ma_SP).Select(p => p.Ma_SP).Take(1).SingleOrDefault();
                var f = Request.Files["anh"];
                var f1 = Request.Files["anh1"];
                var f2 = Request.Files["anh2"];
                db.Anhs.Add(new Anh(maSP, System.IO.Path.GetFileName(f.FileName)));
                db.Anhs.Add(new Anh(maSP, System.IO.Path.GetFileName(f1.FileName)));
                db.Anhs.Add(new Anh(maSP, System.IO.Path.GetFileName(f2.FileName)));

                db.SaveChanges();
                return RedirectToAction("Index");
            }
            catch (Exception ex)
            {
                ViewBag.Error = "Lỗi nhập dữ liệu! " + ex.Message;
                return View();
            }
        }

        // GET: Admin/SanPhams/Edit/5
        public ActionResult Edit(int? id)
        {
            if (Session["tenTK"] != null && (Session["quyen"].Equals(1) || Session["quyen"].Equals(3)))
            {
                if (id == null)
                {
                    return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
                }
                SanPham sanPham = db.SanPhams.Find(id);
                if (sanPham == null)
                {
                    return HttpNotFound();
                }
                ViewBag.Ma_DM = new SelectList(db.DanhMucSPs, "Ma_DM", "Ten_DM", sanPham.Ma_DM);
                ViewBag.SamPhams = db.DanhMucSPs.OrderBy(dm => dm.Ten_DM).Select(dm => dm.Ten_DM).Distinct().ToList();
                return View(sanPham);
            }
            else
            {
                return RedirectToAction("Login", "Home");
            }
        }

        // POST: Admin/SanPhams/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "Ma_SP,Ten_SP,Ma_DM,ThuongHieu_SP,MuiHuong_SP,MucDich_SP,SoLuong_SP,NongDo_SP,DungTich_SP,GiaBan_SP,MoTa_SP")] SanPham sanPham)
        {
            int maSP = Convert.ToInt32(Request.Form["maSP"]);
            SanPham sp = db.SanPhams.Where(p => p.Ma_SP == maSP).FirstOrDefault();
            try
            {
                if (Request != null && sp != null)
                {
                    string tenDM = Request.Form["tenDM"];

                    sp.Ten_SP = Request.Form["tenSP"];
                    sp.Ma_DM = db.DanhMucSPs.Where(n => n.Ten_DM.Equals(tenDM)).Select(n => n.Ma_DM).FirstOrDefault();
                    sp.ThuongHieu_SP = Request.Form["thuongHieu"];
                    sp.MuiHuong_SP = Request.Form["muiHuong"];
                    sp.MucDich_SP = Request.Form["mucDich"];
                    sp.SoLuong_SP = Convert.ToInt32(Request.Form["soLuong"]);
                    sp.NongDo_SP = Request.Form["nongDo"];
                    sp.DungTich_SP = Convert.ToInt32(Request.Form["dungTich"]);
                    sp.GiaBan_SP = Convert.ToInt32(Request.Form["giaBan"]);
                    sp.MoTa_SP = Request.Form["moTa"];
                    
                    db.Entry(sp).State = EntityState.Modified;
                    db.SaveChanges();

                    if (Request.Files["anh"].FileName != "")
                    {
                        sp.Anhs.Skip(0).FirstOrDefault().DuongDanAnh = System.IO.Path.GetFileName(Request.Files["anh"].FileName);
                    }

                    if (Request.Files["anh1"].FileName != "")
                    {
                        sp.Anhs.Skip(1).FirstOrDefault().DuongDanAnh = System.IO.Path.GetFileName(Request.Files["anh1"].FileName);
                    }

                    if (Request.Files["anh2"].FileName != "")
                    {
                        sp.Anhs.Skip(2).FirstOrDefault().DuongDanAnh = System.IO.Path.GetFileName(Request.Files["anh2"].FileName);
                    }

                    db.SaveChanges();
                    return RedirectToAction("Index");
                }
                else
                {
                    ViewBag.Error = "Lỗi nhập dữ liệu!";
                    return View(sp);
                }
            }
            catch (Exception ex)
            {
                ViewBag.Error = "Lỗi! " + ex.Message;
                return View(sp);
            }
        }

        // GET: Admin/SanPhams/Delete/5
        public ActionResult Delete(int? id)
        {
            if (Session["tenTK"] != null && (Session["quyen"].Equals(1) || Session["quyen"].Equals(3)))
            {
                if (id == null)
                {
                    return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
                }
                SanPham sanPham = db.SanPhams.Find(id);
                if (sanPham == null)
                {
                    return HttpNotFound();
                }
                return View(sanPham);
            }
            else
            {
                return RedirectToAction("Login", "Home");
            }
        }

        // POST: Admin/SanPhams/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            SanPham sanPham = db.SanPhams.Find(id);
            try
            {
                var anhs = db.Anhs.Where(i => i.Ma_SP == sanPham.Ma_SP).Select(i => i);
                foreach (Anh item in anhs)
                {
                    db.Anhs.Remove(item);
                }
                var gioHangs = db.GioHangs.Where(c => c.Ma_SP == sanPham.Ma_SP).Select(c => c);
                foreach (GioHang item1 in gioHangs)
                {
                    db.GioHangs.Remove(item1);
                }
                var chiTietDHs = db.ChiTietDHs.Where(d => d.Ma_SP == sanPham.Ma_SP).Select(d => d);
                foreach (ChiTietDH item2 in chiTietDHs)
                {
                    db.ChiTietDHs.Remove(item2);
                }

                db.SanPhams.Remove(sanPham);
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            catch (Exception ex)
            {
                ViewBag.Error = "Có lỗi xảy ra! " + ex.Message;
                return View(sanPham);
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
