using System;
using System.Web;
using System.Linq;
using Nhom_1.Models;
using System.Web.Mvc;
using System.Collections.Generic;

namespace Nhom_1.Areas.Admin.Controllers
{
    public class HomeController : Controller
    {
        ShopNuocHoaDB db = new ShopNuocHoaDB();

        // GET: Admin/Home
        public ActionResult Index()
        {
            if (Session["tenTK"] != null && !Session["quyen"].Equals(2))
            {
                List<int> soLuong = new List<int>();
                soLuong.Add(db.TaiKhoans.Count());
                soLuong.Add(db.DanhMucSPs.Count());
                soLuong.Add(db.SanPhams.Count());
                soLuong.Add(db.DonHangs.Count());
                return View(soLuong);
            }
            else
            {
                return RedirectToAction("Login");
            }
        }

        public ActionResult Login()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Login(string tenTK, string matKhauTK)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    TaiKhoan taiKhoan = db.TaiKhoans.Where(s => s.Ten_TK.Equals(tenTK) && s.MatKhau_TK.Equals(matKhauTK)).FirstOrDefault();
                    if (taiKhoan != null && !taiKhoan.MaQuyen.Equals(2) && taiKhoan.TrangThai_TK == 1)
                    {
                        Session["maTK"] = taiKhoan.Ma_TK;
                        Session["tenTK"] = taiKhoan.Ten_TK;
                        Session["matKhau"] = taiKhoan.MatKhau_TK;
                        Session["hoTen"] = taiKhoan.HoTen_TK;
                        Session["tuoi"] = taiKhoan.Tuoi_TK;
                        Session["diaChi"] = taiKhoan.DiaChi_TK;
                        Session["dienThoai"] = taiKhoan.DienThoai_TK;
                        Session["email"] = taiKhoan.Email_TK;
                        Session["anh"] = taiKhoan.Anh_TK;
                        Session["quyen"] = taiKhoan.MaQuyen;

                        return RedirectToAction("Index");
                    }
                    else
                    {
                        ViewBag.Error = "Đăng nhập thất bại";
                        return RedirectToAction("Login");
                    }
                }
                return View();
            }
            catch (Exception ex)
            {
                ViewBag.Error = "Lỗi!" + ex.Message;
                return RedirectToAction("Login");
            }
        }

        public ActionResult Logout()
        {
            Session.Clear();
            return RedirectToAction("Login");
        }
    }
}