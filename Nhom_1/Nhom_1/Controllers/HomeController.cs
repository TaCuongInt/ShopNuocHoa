using System;
using PagedList;
using System.Web;
using System.Linq;
using Nhom_1.Models;
using System.Web.Mvc;
using System.Data.Entity;
using System.Collections.Generic;

namespace Nhom_1.Controllers
{
    public class HomeController : Controller
    {
        ShopNuocHoaDB db = new ShopNuocHoaDB();

        public ActionResult Index()
        {
            var sanPhams = db.SanPhams.Select(p => p);
            return View(sanPhams);
        }

        public ActionResult Category()
        {
            var danhMucs = db.DanhMucSPs.Select(c => c);
            return PartialView(danhMucs);
        }

        public ActionResult Product_Category(int id, int? page)
        {
            int pageSize = 8;
            int pageNumber = (page ?? 1);
            var sanPhams = db.SanPhams.Where(p => p.Ma_DM.Equals(id)).OrderByDescending(p => p.Ma_SP).Select(p => p);
            return View(sanPhams.ToPagedList(pageNumber, pageSize));
        }

        public ActionResult Product_Detail(int id)
        {
            SanPham sanPham = db.SanPhams.Find(id);
            return View(sanPham);
        }

        public ActionResult Menu(string id)
        {
            switch (id)
            {
                case "GioiThieu":
                    return View("GioiThieu");
                case "TimKiem":
                    return View("Search");
                case "BaoHanh":
                    return View("BaoHanh");
                case "TinTuc":
                    return View("TinTuc");
                case "LienHe":
                    return View("LienHe");
                default:
                    return View("Index");
            }
        }

        [HttpGet]
        public ActionResult Search()
        {
            var sanPhams = db.SanPhams.Select(p => p);
            return View(sanPhams);
        }

        [HttpPost]
        public ActionResult Search(string txtKey, string danhMuc, string thuongHieu, int giaBan, string mucDich, string nongDo, string muiHuong)
        {
            if (txtKey == "")
            {
                var sanPhams = db.SanPhams.Where(p => p.DanhMucSP.Ten_DM.Equals(danhMuc) ||
                                                 p.ThuongHieu_SP.Equals(thuongHieu) ||
                                                 p.GiaBan_SP <= giaBan ||
                                                 p.MucDich_SP.Equals(mucDich) ||
                                                 p.NongDo_SP.Equals(nongDo) ||
                                                 p.MuiHuong_SP.Equals(muiHuong)).Select(p => p);
                return View("Search_Result", sanPhams);
            }
            else
            {
                var sanPhams = db.SanPhams.Where(p => p.DanhMucSP.Ten_DM.Contains(txtKey) ||
                                                 p.ThuongHieu_SP.Contains(txtKey) ||
                                                 p.GiaBan_SP.ToString().Contains(txtKey) ||
                                                 p.MucDich_SP.Contains(txtKey) ||
                                                 p.NongDo_SP.Contains(txtKey) ||
                                                 p.MuiHuong_SP.Contains(txtKey)).Select(p => p);
                return View("Search_Result", sanPhams);
            }
        }

        [HttpGet]
        public ActionResult Register()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Register(string tenTK, string matKhauTK, string matKhauTK1)
        {
            try
            {
                if (ModelState.IsValid && matKhauTK == matKhauTK1)
                {
                    var taiKhoan = db.TaiKhoans.FirstOrDefault(s => s.Ten_TK == tenTK);
                    if (taiKhoan == null)
                    {
                        TaiKhoan taiKhoan1;
                        string anh = Request.Form["ImageFile"];
                        if (anh == null)
                        {
                            taiKhoan1 = new TaiKhoan(tenTK, matKhauTK, 2);
                        }
                        else
                        {
                            taiKhoan1 = new TaiKhoan(tenTK, matKhauTK, anh, 2);
                        }
                        db.Configuration.ValidateOnSaveEnabled = false;
                        db.TaiKhoans.Add(taiKhoan1);
                        db.SaveChanges();
                        return RedirectToAction("Login");
                    }
                    else
                    {
                        ViewBag.Error = "Tên tài khoản đã tồn tại";
                        return View();
                    }
                }
                ViewBag.Error = "Mật khẩu xác nhận không đúng";
                return View();
            }
            catch (Exception ex)
            {
                ViewBag.Error = "Lỗi! " + ex.Message;
                return View();
            }
        }

        [HttpGet]
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
                    TaiKhoan taikhoan = db.TaiKhoans.Where(s => s.Ten_TK.Equals(tenTK) && s.MatKhau_TK.Equals(matKhauTK)).FirstOrDefault();
                    if (taikhoan != null && taikhoan.TrangThai_TK == 1)
                    {
                        if (taikhoan.HoTen_TK == null)
                        {
                            Session["maTK"] = taikhoan.Ma_TK;
                            Session["tenTK"] = taikhoan.Ten_TK;
                            Session["matKhau"] = taikhoan.MatKhau_TK;
                            Session["anh"] = taikhoan.Anh_TK;
                            Session["quyen"] = taikhoan.MaQuyen;
                            return RedirectToAction("Account");
                        }    
                        else
                        {
                            Session["maTK"] = taikhoan.Ma_TK;
                            Session["tenTK"] = taikhoan.Ten_TK;
                            Session["matKhau"] = taikhoan.MatKhau_TK;
                            Session["hoTen"] = taikhoan.HoTen_TK;
                            Session["tuoi"] = taikhoan.Tuoi_TK;
                            Session["diaChi"] = taikhoan.DiaChi_TK;
                            Session["dienThoai"] = taikhoan.DienThoai_TK;
                            Session["email"] = taikhoan.Email_TK;
                            Session["anh"] = taikhoan.Anh_TK;
                            Session["quyen"] = taikhoan.MaQuyen;

                            return RedirectToAction("Index");
                        }
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
                ViewBag.Error = "Lỗi! " + ex.Message;
                return View();
            }
        }

        public ActionResult Logout()
        {
            Session.Clear();
            return RedirectToAction("Login");
        }

        [HttpGet]
        public ActionResult Account()
        {
            if (Session["tenTK"] != null)
            {
                return View();
            }
            else
            {
                return RedirectToAction("Login");
            }
        }

        [HttpPost]
        public ActionResult Account(string tenTK, string matKhau, string hoTen, string tuoi, string diaChi, string soDT, string email, string ImageFile)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    int maTK = Convert.ToInt32(Session["maTK"]);
                    TaiKhoan taiKhoan = db.TaiKhoans.Where(a => a.Ma_TK == maTK).FirstOrDefault();

                    taiKhoan.Ten_TK = tenTK;
                    taiKhoan.MatKhau_TK = matKhau;
                    taiKhoan.HoTen_TK = hoTen;
                    taiKhoan.Tuoi_TK = Convert.ToInt32(tuoi);
                    taiKhoan.DiaChi_TK = diaChi;
                    taiKhoan.DienThoai_TK = soDT;
                    taiKhoan.Email_TK = email;
                    if (ImageFile != "")
                    {
                        taiKhoan.Anh_TK = ImageFile;
                    }

                    db.Configuration.ValidateOnSaveEnabled = false;
                    db.SaveChanges();

                    Session["tenTK"] = tenTK;
                    Session["matKhau"] = matKhau;
                    Session["hoTen"] = hoTen;
                    Session["tuoi"] = Convert.ToInt32(tuoi);
                    Session["diaChi"] = diaChi;
                    Session["dienThoai"] = soDT;
                    Session["email"] = email;
                    if (ImageFile != "")
                    {
                        Session["anh"] = ImageFile;
                    }

                    ViewBag.Error = "Cập nhật thông tin cá nhân thành công";
                }
                return View();
            }
            catch (Exception ex)
            {
                ViewBag.Error = "Lỗi! " + ex.Message;
                return View();
            }
        }

        public ActionResult Cart()
        {
            try
            {
                if (Session["tenTK"] != null)
                {
                    int maTK = Convert.ToInt32(Session["maTK"]);
                    var gioHangs = db.GioHangs.Where(c => c.Ma_TK.Equals(maTK)).Select(c => c);
                    return View("Cart", gioHangs);
                }
                else
                {
                    return RedirectToAction("Login");
                }
            }
            catch (Exception ex)
            {
                ViewBag.Error = "Lỗi! " + ex.Message;
                return View();
            }
        }

        public ActionResult Product_To_Cart(int id)
        {
            try
            {
                if (Session["tenTK"] != null)
                {
                    int maTK = Convert.ToInt32(Session["maTK"]);
                    GioHang gioHang = db.GioHangs.Where(c => c.Ma_SP.Equals(id)).FirstOrDefault();
                    if (gioHang != null && gioHang.Ma_SP.Equals(id) && gioHang.Ma_TK.Equals(maTK))
                    {
                        GioHang a = db.GioHangs.Where(h => h.Ma_SP.Equals(id)).FirstOrDefault();
                        a.SoLuong_GH++;
                        db.Entry(a).State = EntityState.Modified;
                        db.SaveChanges();
                    }
                    else
                    {
                        db.GioHangs.Add(new GioHang(maTK, id, 1));
                        db.SaveChanges();
                    }
                    return RedirectToAction("Cart");
                }
                else
                {
                    return RedirectToAction("Login");
                }
            }
            catch (Exception ex)
            {
                ViewBag.Error = "Lỗi! " + ex.Message;
                return RedirectToAction("Cart");
            }
        }

        [HttpPost]
        public ActionResult Edit_Cart(int id)
        {
            int maTK = Convert.ToInt32(Session["maTK"]);
            int soLuongGH = Convert.ToInt32(Request.Form["soLuong"]);
            var gioHangs = db.GioHangs.Where(h => h.Ma_TK.Equals(maTK)).Select(h => h);
            try
            {
                int maSP = gioHangs.Where(c => c.Ma_GH.Equals(id)).Select(c => c).FirstOrDefault().Ma_SP;
                int soLuongSP = Convert.ToInt32(db.SanPhams.Where(c => c.Ma_SP.Equals(maSP)).Select(c => c).FirstOrDefault().SoLuong_SP);
                if (soLuongGH > soLuongSP)
                {
                    ViewBag.Error = "Số lượng sản phẩm bạn đặt nhiều hơn số lượng hiện có trong kho. Vui lòng đặt lại!";
                    return RedirectToAction("Cart");
                }

                if (soLuongGH.Equals(0))
                {
                    GioHang gioHang = gioHangs.Where(c => c.Ma_GH.Equals(id)).Select(c => c).FirstOrDefault();
                    db.GioHangs.Remove(gioHang);
                    db.SaveChanges();
                    return RedirectToAction("Cart");
                }
                else
                {
                    if (Request != null && gioHangs != null)
                    {
                        GioHang gioHang = gioHangs.Where(c => c.Ma_GH.Equals(id)).Select(c => c).FirstOrDefault();
                        gioHang.SoLuong_GH = soLuongGH;
                        db.Entry(gioHang).State = EntityState.Modified;
                        db.SaveChanges();
                        return RedirectToAction("Cart");
                    }
                    else
                    {
                        ViewBag.Error = "Lỗi nhập dữ liệu!";
                        return RedirectToAction("Cart");
                    }
                }
            }
            catch (Exception ex)
            {
                ViewBag.Error = "Lỗi! " + ex.Message;
                return RedirectToAction("Cart");
            }
        }

        public ActionResult Delete_Cart(int id)
        {
            int maTK = Convert.ToInt32(Session["maTK"]);
            var gioHangs = db.GioHangs.Where(c => c.Ma_TK.Equals(maTK)).Select(c => c);
            try
            {
                if (Session["tenTK"] != null)
                {
                    if (id.Equals(0))
                    {
                        foreach (GioHang gioHang in gioHangs)
                        {
                            db.GioHangs.Remove(gioHang);
                        }
                        db.SaveChanges();
                        return RedirectToAction("Cart");
                    }
                    else
                    {
                        GioHang gioHang = gioHangs.Where(c => c.Ma_GH.Equals(id)).Select(c => c).FirstOrDefault();
                        db.GioHangs.Remove(gioHang);
                        db.SaveChanges();
                        return RedirectToAction("Cart");
                    }
                }
                else
                {
                    return RedirectToAction("Login");
                }
            }
            catch (Exception ex)
            {
                ViewBag.Error = "Lỗi! " + ex.Message;
                return RedirectToAction("Cart");
            }
        }

        [HttpPost]
        public ActionResult Order()
        {
            try
            {
                int maTK = Convert.ToInt32(Session["maTK"]);
                string dienThoai = Request.Form["dienThoai"];
                string hoTen = Request.Form["hoTen"];
                string email = Request.Form["email"];
                string diaChi = Request.Form["diaChi"];
                string ghiChu = Request.Form["ghiChu"];

                db.DonHangs.Add(new DonHang(maTK, DateTime.Now, 1, dienThoai, hoTen, email, diaChi, ghiChu));
                db.SaveChanges();

                int maDH = db.DonHangs.OrderByDescending(o => o.Ma_DH).Select(o => o.Ma_DH).Take(1).SingleOrDefault();
                var gioHangs = db.GioHangs.Where(c => c.Ma_TK.Equals(maTK)).Select(c => c);

                foreach (GioHang item in gioHangs)
                {
                    db.ChiTietDHs.Add(new ChiTietDH(maDH, item.Ma_SP, item.SoLuong_GH));
                    db.GioHangs.Remove(item);
                }

                db.SaveChanges();
                return RedirectToAction("Cart");
            }
            catch (Exception ex)
            {
                ViewBag.Error = "Lỗi! " + ex.Message;
                return RedirectToAction("Cart");
            }
        }
    }
}