using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;

public class GenerateStaticCubemap : ScriptableWizard {

    public Transform renderPosition;
    public Cubemap cubemap;

    private void OnWizardUpdate()
    {
        helpString = "select transform to render" + "from and cubemap to render into";

        if (null != renderPosition && null != cubemap)
        {
            isValid = true; // 如果isValid为true，可以执行OnWizardCreate
        }
        else
        {
            isValid = false;
        }
    }

    private void OnWizardCreate()
    {
        GameObject go = new GameObject("CubeCam", typeof(Camera));

        go.transform.position = renderPosition.position;
        go.transform.rotation = Quaternion.identity;

        go.GetComponent<Camera>().RenderToCubemap(cubemap);

        DestroyImmediate(go);
    }

    [MenuItem("ShaderPractice/Render Cubemap")]
    static void RenderCubemap()
    {
        ScriptableWizard.DisplayWizard("Render CubeMap", typeof(GenerateStaticCubemap), "Render!");
    }
}
