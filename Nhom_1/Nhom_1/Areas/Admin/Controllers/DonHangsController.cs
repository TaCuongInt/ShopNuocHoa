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
    public class DonHangsController : Controller
    {
        private ShopNuocHoaDB db = new ShopNuocHoaDB();

        // GET: Admin/DonHangs
        public ActionResult Index(string sortOrder, string searchString, string curentFilter, int? page)
        {
            if (Session["tenTK"] != null && (Session["quyen"].Equals(1) || Session["quyen"].Equals(4)))
            {
                ViewBag.SapTheoMaDH = sortOrder == "MaDH" ? "maDH_desc" : "MaDH";
                ViewBag.SapTheoTenTK = sortOrder == "TenTK" ? "tenTK_desc" : "TenTK";
                ViewBag.SapTheoTenND = String.IsNullOrEmpty(sortOrder) ? "tenND_desc" : "";
                ViewBag.SapTheoDienThoai = String.IsNullOrEmpty(sortOrder) ? "dienThoai_desc" : "";
                ViewBag.SapTheoEmail = String.IsNullOrEmpty(sortOrder) ? "email_desc" : "";
                ViewBag.SapTheoDiaChi = String.IsNullOrEmpty(sortOrder) ? "diaChi_desc" : "";
                ViewBag.SapTheoGhiChu = String.IsNullOrEmpty(sortOrder) ? "ghiChu_desc" : "";
                ViewBag.SapTheoNgayDat = String.IsNullOrEmpty(sortOrder) ? "ngayDat_desc" : "";
                ViewBag.SapTheoTrangThai = sortOrder == "TrangThai" ? "trangThai_desc" : "TrangThai";

                if (searchString != null)
                {
                    page = 1;
                }
                else
                {
                    searchString = curentFilter;
                }

                ViewBag.CurentFilter = searchString;
                var donHangs = db.DonHangs.Include(d => d.TaiKhoan);

                if (!String.IsNullOrEmpty(searchString))
                {
                    donHangs = donHangs.Where(s => s.TaiKhoan.Ten_TK.Contains(searchString));
                }

                switch (sortOrder)
                {
                    case "maDH_desc":
                        donHangs = donHangs.OrderByDescending(s => s.Ma_DH);
                        break;
                    case "tenTK_desc":
                        donHangs = donHangs.OrderByDescending(s => s.TaiKhoan.Ten_TK);
                        break;
                    case "tenND_desc":
                        donHangs = donHangs.OrderByDescending(s => s.HoTen_DH);
                        break;
                    case "dienThoai_desc":
                        donHangs = donHangs.OrderByDescending(s => s.DienThoai_DH);
                        break;
                    case "email_desc":
                        donHangs = donHangs.OrderByDescending(s => s.TaiKhoan.Email_TK);
                        break;
                    case "diaChi_desc":
                        donHangs = donHangs.OrderByDescending(s => s.DiaChi_DH);
                        break;
                    case "ghiChu_desc":
                        donHangs = donHangs.OrderByDescending(s => s.GhiChu_DH);
                        break;
                    case "ngayDat_desc":
                        donHangs = donHangs.OrderByDescending(s => s.NgayDat_DH);
                        break;
                    case "trangThai_desc":
                        donHangs = donHangs.OrderByDescending(s => s.TrangThai_DH);
                        break;
                    default:
                        donHangs = donHangs.OrderBy(s => s.Ma_DH);
                        break;
                }

                int pageSize = 10;
                int pageNumber = (page ?? 1);

                return View(donHangs.ToPagedList(pageNumber, pageSize));
            }
            else
            {
                return RedirectToAction("Login", "Home");
            }
        }

        // GET: Admin/DonHangs/Details/5
        public ActionResult Details(int? id, string sortOrder, string searchString, string curentFilter, int? page)
        {
            if (Session["tenTK"] != null && (Session["quyen"].Equals(1) || Session["quyen"].Equals(4)))
            {
                ViewBag.SapTheoMaBanGhi = sortOrder == "MaBanGhi" ? "maBanGhi_desc" : "MaBanGhi";
                ViewBag.SapTheoMaDH = sortOrder == "MaDH" ? "maDH_desc" : "MaDH";
                ViewBag.SapTheoTenSP = String.IsNullOrEmpty(sortOrder) ? "tenSP_desc" : "";
                ViewBag.SapTheoSoLuong = sortOrder == "SoLuong" ? "soLuong_desc" : "SoLuong";

                ViewBag.TenTK = db.DonHangs.Where(d => d.Ma_TK == id).Select(d => d.TaiKhoan.Ten_TK).FirstOrDefault();

                if (searchString != null)
                {
                    page = 1;
                }
                else
                {
                    searchString = curentFilter;
                }

                ViewBag.CurentFilter = searchString;
                var chiTietDH = db.ChiTietDHs.Where(d => d.Ma_DH == id).Select(d => d);

                if (!String.IsNullOrEmpty(searchString))
                {
                    chiTietDH = chiTietDH.Where(s => s.SanPham.Ten_SP.Contains(searchString));
                }

                switch (sortOrder)
                {
                    case "maBanGhi_desc":
                        chiTietDH = chiTietDH.OrderByDescending(s => s.Ma_CT);
                        break;
                    case "maDH_desc":
                        chiTietDH = chiTietDH.OrderByDescending(s => s.Ma_DH);
                        break;
                    case "tenSP_desc":
                        chiTietDH = chiTietDH.OrderByDescending(s => s.SanPham.Ten_SP);
                        break;
                    case "soLuong_desc":
                        chiTietDH = chiTietDH.OrderByDescending(s => s.SoLuong_CT);
                        break;
                    default:
                        chiTietDH = chiTietDH.OrderBy(s => s.Ma_CT);
                        break;
                }

                int pageSize = 10;
                int pageNumber = (page ?? 1);

                return View(chiTietDH.ToPagedList(pageNumber, pageSize));
            }
            else
            {
                return RedirectToAction("Login", "Home");
            }
        }

        // GET: Admin/DonHangs/Edit/5
        public ActionResult Edit(int? id)
        {
            if (Session["tenTK"] != null && (Session["quyen"].Equals(1) || Session["quyen"].Equals(4)))
            {
                if (id == null)
                {
                    return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
                }
                DonHang donHang = db.DonHangs.Find(id);
                if (donHang == null)
                {
                    return HttpNotFound();
                }
                ViewBag.Ma_TK = new SelectList(db.TaiKhoans, "Ma_TK", "Ten_TK", donHang.Ma_TK);
                return View(donHang);
            }
            else
            {
                return RedirectToAction("Login", "Home");
            }
        }

        // POST: Admin/DonHangs/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(int id)
        {
            DonHang donHang = db.DonHangs.Where(c => c.Ma_DH == id).FirstOrDefault();
            if (Request != null && donHang != null)
            {
                try
                {
                    donHang.TrangThai_DH = Convert.ToInt32(Request.Form["trangThai"]);
                    db.Entry(donHang).State = EntityState.Modified;
                    db.SaveChanges();
                    return RedirectToAction("Index");
                }
                catch (Exception ex)
                {
                    ViewBag.Error = "Lỗi nhập dữ liệu! " + ex.Message;
                    return View(donHang);
                }
            }
            else
            {
                ViewBag.Error = "Lỗi nhập dữ liệu!";
                return View(donHang);
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