{ lib
, buildPythonPackage
, fetchPypi
, setuptools
, numpy
, opencv4
, pyyaml
, qudida
, scikit-image
, scipy
, deepdiff
, pytestCheckHook
, pythonOlder
, pythonRelaxDepsHook
, torch
, torchvision
}:

buildPythonPackage rec {
  pname = "albumentations";
  version = "1.4.4";
  pyproject = true;

  disabled = pythonOlder "3.8";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-VNpClOBdoaQOqU92Mm/Z5Q7P+fZzR+m43SFA9pSi1M0=";
  };

  nativeBuildInputs = [
    pythonRelaxDepsHook
  ];

  pythonRemoveDeps = [
    "opencv-python"
  ];

  build-system = [
    setuptools
  ];

  dependencies = [
    numpy
    opencv4
    pyyaml
    qudida
    scikit-image
    scipy
  ];

  nativeCheckInputs = [
    deepdiff
    pytestCheckHook
    torch
    torchvision
  ];

  disabledTests = [
    # this test hangs up
    "test_transforms"
  ];

  pythonImportsCheck = [ "albumentations" ];

  meta = with lib; {
    description = "Fast image augmentation library and easy to use wrapper around other libraries";
    homepage = "https://github.com/albumentations-team/albumentations";
    changelog = "https://github.com/albumentations-team/albumentations/releases/tag/${version}";
    license = licenses.mit;
    maintainers = with maintainers; [ natsukium ];
  };
}
