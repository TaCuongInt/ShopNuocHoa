using System;
using PagedList;
using System.Net;
using System.Web;
using System.Linq;
using System.Data;
using Nhom_1.Models;
using System.Web.Mvc;
using System.Data.Entity;
using System.Collections.Generic;

namespace Nhom_1.Areas.Admin.Controllers
{
    public class TaiKhoansController : Controller
    {
        private ShopNuocHoaDB db = new ShopNuocHoaDB();

        // GET: Admin/TaiKhoans
        public ActionResult Index(string sortOrder, string searchString, string curentFilter, int? page)
        {
            if (Session["tenTK"] != null && Session["quyen"].Equals(1))
            {
                ViewBag.SapTheoMaTK = sortOrder == "MaTK" ? "maTK_desc" : "MaTK";
                ViewBag.SapTheoTenTK = String.IsNullOrEmpty(sortOrder) ? "tenTK_desc" : "";
                ViewBag.SapTheoMatKhau = String.IsNullOrEmpty(sortOrder) ? "matKhau_desc" : "";
                ViewBag.SapTheoHoTen = String.IsNullOrEmpty(sortOrder) ? "hoTen_desc" : "";
                ViewBag.SapTheoTenTuoi = sortOrder == "Tuoi" ? "tuoi_desc" : "Tuoi";
                ViewBag.SapTheoDienThoai = String.IsNullOrEmpty(sortOrder) ? "dienThoai_desc" : "";
                ViewBag.SapTheoTrangThai = sortOrder == "TrangThai" ? "trangThai_desc" : "TrangThai";
                ViewBag.SapTheoQuyen = String.IsNullOrEmpty(sortOrder) ? "quyen_desc" : "";

                if (searchString != null)
                {
                    page = 1;
                }
                else
                {
                    searchString = curentFilter;
                }

                ViewBag.CurentFilter = searchString;
                var taiKhoans = db.TaiKhoans.Select(a => a);

                if (!String.IsNullOrEmpty(searchString))
                {
                    taiKhoans = taiKhoans.Where(a => a.Ten_TK.Contains(searchString));
                }

                switch (sortOrder)
                {
                    case "maTK_desc":
                        taiKhoans = taiKhoans.OrderByDescending(s => s.Ma_TK);
                        break;
                    case "tenTK_desc":
                        taiKhoans = taiKhoans.OrderByDescending(s => s.Ten_TK);
                        break;
                    case "matKhau_desc":
                        taiKhoans = taiKhoans.OrderByDescending(s => s.MatKhau_TK);
                        break;
                    case "hoTen_desc":
                        taiKhoans = taiKhoans.OrderByDescending(s => s.HoTen_TK);
                        break;
                    case "tuoi_desc":
                        taiKhoans = taiKhoans.OrderByDescending(s => s.Tuoi_TK);
                        break;
                    case "dienThoai_desc":
                        taiKhoans = taiKhoans.OrderByDescending(s => s.DienThoai_TK);
                        break;
                    case "trangThai_desc":
                        taiKhoans = taiKhoans.OrderByDescending(s => s.TrangThai_TK);
                        break;
                    case "quyen_desc":
                        taiKhoans = taiKhoans.OrderByDescending(s => s.Quyen.TenQuyen);
                        break;
                    default:
                        taiKhoans = taiKhoans.OrderBy(s => s.Ma_TK);
                        break;
                }

                int pageSize = 10;
                int pageNumber = (page ?? 1);

                return View(taiKhoans.ToPagedList(pageNumber, pageSize));
            }
            else
            {
                return RedirectToAction("Login", "Home");
            }
        }

        // GET: Admin/TaiKhoans/Details/5
        public ActionResult Details(int? id)
        {
            if (Session["tenTK"] != null && Session["quyen"].Equals(1))
            {
                if (id == null)
                {
                    return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
                }
                TaiKhoan taiKhoans = db.TaiKhoans.Find(id);
                if (taiKhoans == null)
                {
                    return HttpNotFound();
                }
                return View(taiKhoans);
            }
            else
            {
                return RedirectToAction("Login", "Home");
            }
        }

        // GET: Admin/TaiKhoans/Edit/5
        public ActionResult Edit(int? id)
        {
            if (Session["tenTK"] != null)
            {
                if (id == null)
                {
                    return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
                }
                TaiKhoan taiKhoans = db.TaiKhoans.Find(id);
                if (taiKhoans == null)
                {
                    return HttpNotFound();
                }
                ViewBag.MaQuyen = new SelectList(db.Quyens, "MaQuyen", "TenQuyen", taiKhoans.MaQuyen);
                return View(taiKhoans);
            }
            else
            {
                return RedirectToAction("Login", "Home");
            }
        }

        // POST: Admin/TaiKhoans/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(int id)
        {
            TaiKhoan taiKhoan = db.TaiKhoans.Where(c => c.Ma_TK == id).FirstOrDefault();
            if (Request != null && taiKhoan != null)
            {
                try
                {
                    taiKhoan.TrangThai_TK = Convert.ToInt32(Request.Form["trangThai"]);
                    taiKhoan.MaQuyen = Convert.ToInt32(Request.Form["quyen"]);

                    db.Entry(taiKhoan).State = EntityState.Modified;
                    db.SaveChanges();
                    return RedirectToAction("Index");
                }
                catch (Exception ex)
                {
                    ViewBag.Error = "Lỗi nhập dữ liệu! " + ex.Message;
                    return View(taiKhoan);
                }
            }
            else
            {
                ViewBag.Error = "Lỗi nhập dữ liệu!";
                return View(taiKhoan);
            }
        }

        // GET: Admin/TaiKhoans/Delete/5
        public ActionResult Delete(int? id)
        {
            if (Session["tenTK"] != null && Session["quyen"].Equals(1))
            {
                if (id == null)
                {
                    return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
                }
                TaiKhoan taiKhoan = db.TaiKhoans.Find(id);
                if (taiKhoan == null)
                {
                    return HttpNotFound();
                }
                return View(taiKhoan);
            }
            else
            {
                return RedirectToAction("Login", "Home");
            }
        }

        // POST: Admin/TaiKhoans/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            TaiKhoan taiKhoan = db.TaiKhoans.Where(a => a.Ma_TK == id).FirstOrDefault();
            try
            {
                if (taiKhoan.Ma_TK == Convert.ToInt32(Session["maTK"]))
                {
                    ViewBag.Message = "Không thể xóa tài khoản đang đăng nhập!";
                    return View(taiKhoan);
                }
                else
                {
                    var gioHangs = db.GioHangs.Where(c => c.Ma_TK == id).Select(c => c);
                    foreach (GioHang item in gioHangs)
                    {
                        db.GioHangs.Remove(item);
                    }

                    var donHangs = db.DonHangs.Where(o => o.Ma_TK == id).Select(o => o);
                    foreach (DonHang item in donHangs)
                    {
                        db.DonHangs.Remove(item);
                    }

                    int maDH = db.DonHangs.Where(o => o.Ma_TK == id).Select(o => o.Ma_DH).FirstOrDefault();
                    var chiTietDHs = db.ChiTietDHs.Where(d => d.Ma_DH == maDH).Select(d => d);
                    foreach (ChiTietDH item in chiTietDHs)
                    {
                        db.ChiTietDHs.Remove(item);
                    }

                    db.TaiKhoans.Remove(taiKhoan);
                    db.SaveChanges();
                    return RedirectToAction("Index");
                }
            }
            catch (Exception ex)
            {
                ViewBag.Error = "Lỗi! " + ex.Message;
                return View(taiKhoan);
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
